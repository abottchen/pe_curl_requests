#!/bin/bash
# This script searches PuppetDB specifically for any Host entries that
# have been marked as 'exported' with Puppet (i.e. someone declared an exported
# host resource like @@host { ... }). I wrote this for our Architect class, but
# you can modify the query to do whatever you like

SET_SERVER=$(puppet config print server)
PUPPETDB="${PUPPETDB:-$SET_SERVER}"

curl -X GET \
  --tlsv1 \
  --data-urlencode query='["and", ["=","exported", true], ["=", "type", "Host"]]' \
  --cert   $(puppet config print hostcert) \
  --key    $(puppet config print hostprivkey) \
  --cacert $(puppet config print localcacert) \
  https://${PUPPETDB}:8081/pdb/query/v4/resources | python -m json.tool
