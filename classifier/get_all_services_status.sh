#!/bin/bash

SET_SERVER=$(puppet config print server)
CONSOLE="${CONSOLE:-$SET_SERVER}"

curl -X GET \
  --tlsv1 \
  --cert   $(puppet config print hostcert) \
  --key    $(puppet config print hostprivkey) \
  --cacert $(puppet config print localcacert) \
  https://"${CONSOLE}":4433/status/v1/services | python -m json.tool
