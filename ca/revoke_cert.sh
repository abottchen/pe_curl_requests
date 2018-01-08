#!/bin/sh

MASTER="pe-201732-master.puppetdebug.vlan"
AGENT="pe-201732-agent.puppetdebug.vlan"

curl -k -X PUT -H 'Content-Type: application/json' --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey) --cacert $(puppet config print cacert) "https://${MASTER}:8140/puppet-ca/v1/certificate_status/${AGENT}?environment=production" -d '{"desired_state":"revoked"}'
