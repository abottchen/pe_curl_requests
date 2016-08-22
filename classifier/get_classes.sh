#!/bin/bash

curl https://$(hostname -f):4433/classifier-api/v1/classes --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey) --cacert $(puppet config print localcacert) -H "Content-Type: application/json" |python -m json.tool
