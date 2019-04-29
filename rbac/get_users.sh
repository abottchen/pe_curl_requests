#!/bin/bash

curl --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey)  --cacert $(puppet config print localcacert) https://$(hostname -f):4433/rbac-api/v1/users
