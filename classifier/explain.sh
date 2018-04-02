#!/bin/sh

HOSTNAME=machineto.look.up curl -X POST --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey) --cacert $(puppet config print localcacert) https://$(hostname -f):4433/classifier-api/v1/classified/nodes/$HOSTNAME/explanation --data "$(ssh $HOSTNAME puppet facts |egrep -v '(timestamp":|expiration":)' |sed -e 's/"values":/"fact":/' |sed -e 's/^  },$/  }/')" -H "Content-Type: application/json"

# This one will query for the last facts submitted.  Can be run on the AIO master without needing an ssh login to pull the facts
HOSTNAME=machineto.look.up curl -X POST --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey) --cacert $(puppet config print localcacert) https://$(hostname -f):4433/classifier-api/v1/classified/nodes/$(hostname -f)/explanation --data "$(puppet query 'inventory[certname,facts] { certn
ame = $HOSTNAME }' |tail -n +2 |head -n -1 |sed -e 's/^  //' |sed -e 's/^  "certname":/  "name":/' |sed -e 's/^  "facts"/  "fact"/')" -H "Content-Type: application/json" 
