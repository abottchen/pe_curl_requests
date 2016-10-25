#!/bin/bash
curl -k https://$(hostname -f):4433/classifier-api/v1/groups --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey) --cacert $(puppet config print localcacert) | python -m json.tool
