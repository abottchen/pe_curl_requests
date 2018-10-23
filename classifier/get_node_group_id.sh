#!/bin/bash

SET_SERVER=$(puppet config print server)
CONSOLE="${CONSOLE:-$SET_SERVER}"
NODE_GROUP=$1
RUBY=/opt/puppetlabs/puppet/bin/ruby

curl -s -X GET https://${CONSOLE}:4433/classifier-api/v1/groups \
  --cert $(puppet config print hostcert) \
  --key $(puppet config print hostprivkey) \
  --cacert $(puppet config print localcacert) \
  -H "Content-Type: application/json" \
  | $RUBY -p -e "gsub(/^(\[.*|.+},)({.+\"name\":\"${NODE_GROUP}\".+?}})(,{|\]).+$/, \"\\\\2\")" \
  | $RUBY -p -e 'gsub(/^.+"id":"(.+?)".+$/, "\\1")'

