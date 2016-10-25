#!/bin/sh

PASSWORD="puppetlabs"
EMAIL="deploy@puppetlabs.com"

curl -X POST -H 'Content-Type: application/json' --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey) --cacert $(puppet config print cacert) https://$(hostname -f):4433/rbac-api/v1/users -d '{"login":"deploy","email":"${EMAIL}","display_name":"Deploy User","role_ids": [2],"password":"${PASSWORD}"}'
