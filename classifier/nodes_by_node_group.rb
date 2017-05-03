#!/opt/puppetlabs/puppet/bin/ruby

require 'json'
require 'optparse'

def debug(str)
  puts "DEBUG: #{str}" if $options[:debug] 
end

# curl data from a specified url
def curl_data(command)
  debug "Running command '#{command}'"
  data = `#{command}`
  retcode = $?.exitstatus
  if(retcode != 0) then
    if(retcode == 7) then
      puts "ERROR: Unable to reach #{command.match(/(http.*)/)}"
    else
      puts "ERROR: Failed to curl endpoint, retcode=#{retcode}"
    end
    exit retcode
  end
  return data
end

# List out node groups
def list_groups 
  $groups.sort_by! { |g| g['name'] }
  $groups.each do |g|
#    puts "#{g['environment_trumps'] ? '(env group) ' : ''}#{g['name']}"
    puts g['name']
  end
  return nil
end

# Create a hash mapping group id to name
def build_id_to_name() 
  ret = {}
  $groups.each do |g|
    ret[g['name'].downcase] = g['id']
  end
  return ret
end

# Return a list of rules
def get_rules(arr, group_id,first=true)
  $groups.each do |group|
    if(group['id'] == group_id) then
      if(group['rule'].to_s != '') then
        debug "Translating rule '#{group['rule'].to_s}' for group '#{group['name']}'"
        
        data = curl_data("curl -s -X POST --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey) --cacert $(puppet config print localcacert) https://#{$options[:console]}:4433/classifier-api/v1/rules/translate -H 'Content-Type: application/json' --data '#{group['rule'].to_s}'")
        parsed_rules = JSON.parse(data)

        debug "Adding rules translated rules '#{parsed_rules['query'].to_s}'"
        arr << parsed_rules['query'].to_s
      elsif(first) then
        debug "Initial group has no rules, so nothing matches"
        arr << '["=","certname","No Matches"]'
        return nil
      end
      if(group['id'] != group['parent']) then
        get_rules(arr, group['parent'], false)
      end
    end
  end
  return nil
end

def build_query_string(arr)
  if(arr.length == 0) then
    debug "No rules found for '#{$group_to_find}'"
    debug $groups
  elsif(arr.length == 1)
    query_string = "#{arr[0]}"
  elsif(arr.length == 2)
    query_string = "[\"and\",#{arr.join ","}]"
  else
    query_string = "[\"and\",#{arr.pop},#{arr.pop}]"
    while(arr.length > 0) do
      query_string = "[\"and\",#{query_string},#{arr.pop}]"
    end
  end
  
  # If the query string is empty, then we don't want to match anything.
#  if(query_string.nil?) then
#    query_string = '["=","certname","No Matches"]'
#  end
  
  query_string.gsub! '"name"', '"certname"'
  debug "Final query string = '#{query_string}'"
  return query_string
end

# main

$options = {}
$options[:pdb] = "localhost"
$options[:console] = `hostname -f`.chomp
OptionParser.new do |opts|
  opts.banner = "Usage: nodes_by_node_group.rb [flags] <Group Name> or nodes_by_node_group.rb --list"
  opts.on("-d","--debug","Enable debug output") do |d|
    $options[:debug] = d
  end
  opts.on("-l","--list","List available groups") do |l|
    $options[:list] = l
  end
  opts.on("-p","--puppetdb <hostname>","Fully qualified hostname of the PuppetDB node") do |p|
    $options[:pdb] = p
  end
  opts.on("-c","--console <hostname>","Fully qualified hostname of the Console node") do |c|
    $options[:console] = c
  end
end.parse!

data = curl_data("curl -s --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey) --cacert $(puppet config print localcacert) https://#{$options[:console]}:4433/classifier-api/v1/groups")
$groups = JSON.parse(data)

if($options[:list]) then
  list_groups
  exit 0
end

$group_to_find ||= ARGV.join " "
$group_to_find = $group_to_find.downcase
if($group_to_find == '') then
  puts "No group specified!"
  exit -1
end

id_hash = build_id_to_name
if !(id_hash.has_key?($group_to_find)) then
  puts "ERROR: No group named '#{$group_to_find}' present on #{$options[:console]}."
  exit -1
end

get_rules(arr = [], id_hash[$group_to_find])
query_string = build_query_string(arr)

data = curl_data("curl -s --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey) --cacert $(puppet config print localcacert) -G https://#{$options[:pdb]}:8081/pdb/query/v4/nodes --data-urlencode 'query=#{query_string}'")
nodes = JSON.parse(data)

title = "Nodes for the class '#{$group_to_find}'"
puts title
puts "=" * title.length
if(nodes.count != 0) then
  nodes.each do |node|
    puts node['certname']
  end
end
puts "Total nodes: #{nodes.count}"
