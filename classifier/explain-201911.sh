#!/bin/sh

HOSTNAME=pe-201911-master.puppetdebug.vlan \
curl -X POST --cert $(puppet config print hostcert) \
--key $(puppet config print hostprivkey) \
--cacert $(puppet config print localcacert) \
https://$(hostname -f):4433/classifier-api/v1/classified/nodes/$HOSTNAME/explanation \
--data "$(puppet query "inventory[certname,facts] { certname='$HOSTNAME' }" |tail -n +2 |head -n -1 |sed -e 's/^  //' |sed -e 's/^  "certname":/ "name":/' |sed -e 's/^  "facts"/ "fact"/')" \
-H "Content-Type: application/json" > \
/tmp/classification-exp-test.json
