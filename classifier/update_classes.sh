#!/bin/bash
# This command will update classes on the console node
curl -X POST https://$(hostname -f):4433/classifier-api/v1/update-classes?environment=production --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey) --cacert $(puppet config print localcacert)
