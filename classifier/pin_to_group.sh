#!/bin/bash

# Change the group to match the node group needed.  This is for PE Master for compile master additions.
curl -k https://$(hostname -f):4433/classifier-api/v1/groups --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey) --cacert $(puppet config print localcacert) | python -m json.tool |grep -C 5 "PE Master"

# Use the "id" field from the above in the URL to add the rule for the new master
curl -X POST -H 'Content-Type: application/json' --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey) --cacert $(puppet config print localcacert) https://$(hostname -f):4433/classifier-api/v1/groups/9492547d-dbfb-4165-9b1c-f45fd143ed25/pin?nodes=pe-201645-master.puppetdebug.vlan
