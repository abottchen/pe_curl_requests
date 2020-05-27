# Send an AST based query to PDB.  This is what CD4PE uses, so it allows one to repro cd4pe PDB interactions
# Expects a file named `query.txt` to exist in the $CWD.  The contents of that file is just the AST query itself
#
# for example:
# ["extract", [["function", "count"]], ["=","type","File"]]
#
# Uses ruby to do the url-encode because the curl --url-encode cannot be used at the same time as the -G flag,
# which is needed for this query to work.

curl -G -X GET --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey) --cacert $(puppet config print localcacert) https://$(hostname -f):8081/pdb/query/v4/resources -d "query=$(cat query.txt | /opt/puppetlabs/puppet/bin/ruby -e 'require "cgi"; while STDIN.gets; puts CGI.escape $_; end')"
