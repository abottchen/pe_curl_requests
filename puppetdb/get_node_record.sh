#!/bin/bash

SET_SERVER=$(puppet config print server)
PUPPETDB="${PUPPETDB:-$SET_SERVER}"
NODE='mynode.puppetdebug.vlan'

curl -X GET \
  --tlsv1 \
  --cert   $(puppet config print hostcert) \
  --key    $(puppet config print hostprivkey) \
  --cacert $(puppet config print localcacert) \
  https://${PUPPETDB}:8081/pdb/query/v4/nodes/${NODE}
  # VERSION 3 QUERY BELOW
  # https://${PUPPETDB}:8081/v3/nodes/${NODE}
