#!/bin/bash

curl --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey)  --cacert $(puppet config print localcacert) https://$(grep server /etc/puppetlabs/puppet/classifier.yaml |cut -d" " -f 2):4433/rbac-api/v1/users
