#!/bin/sh

curl --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey)  --cacert $(puppet config print localcacert) -X DELETE https://$(hostname -f):8140/puppet-admin-api/v1/environment-cache
