#!/bin/bash

SET_SERVER=$(puppet config print ca_name | sed 's/^.*\s//')
CA="${CA:-$SET_SERVER}"
NODE='mynode.puppetdebug.vlan'

curl -X PUT \
  -H "Content-Type: text/pson" \
  --tlsv1 \
  --cert   $(puppet config print hostcert) \
  --key    $(puppet config print hostprivkey) \
  --cacert $(puppet config print localcacert) \
  https://${CA}:8140/puppet-ca/v1/certificate_status/${NODE}?environment=production \
  --data '{"desired_state":"signed"}' | python -m json.tool
