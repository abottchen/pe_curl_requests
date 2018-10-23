#!/bin/bash

SET_SERVER=$(puppet config print server)
CONSOLE="${CONSOLE:-$SET_SERVER}"
NODE='yournode.puppetdebug.vlan'

curl -k -X GET https://${CONSOLE}:4433/classifier-api/v1/nodes/${NODE} \
  --cert $(puppet config print hostcert) \
  --key $(puppet config print hostprivkey) \
  --cacert $(puppet config print localcacert) \
  -H "Content-Type: application/json" | python -m json.tool
