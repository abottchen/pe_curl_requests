#!/bin/sh

HOSTNAME=machineto.look.up curl -X POST --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey) --cacert $(puppet config print localcacert) https://$(hostname -f):4433/classifier-api/v1/classified/nodes/$HOSTNAME/explanation --data "$(ssh $HOSTNAME puppet facts |egrep -v '(timestamp":|expiration":)' |sed -e 's/"values":/"fact":/' |sed -e 's/^  },$/  }/')" -H "Content-Type: application/json"
