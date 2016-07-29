#!/bin/bash
curl --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey)  --cacert $(puppet config print localcacert) https://$(hostname -f):8140/puppet/v3/environments
