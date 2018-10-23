#!/bin/bash

# The -I argument doesn't work in OS X -_-
# Feel free to adjust the days
CUTOFF_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ" -d '-1 day')
SET_SERVER=$(puppet config print server)
PUPPETDB="${PUPPETDB:-$SET_SERVER}"

curl -X GET \
  --tlsv1 \
  --cert   $(puppet config print hostcert) \
  --key    $(puppet config print hostprivkey) \
  --cacert $(puppet config print localcacert) \
  --data-urlencode "query=[\"<\", \"report_timestamp\", \"${CUTOFF_DATE}\"]" \
  https://${PUPPETDB}:8081/pdb/query/v4/nodes | python -m json.tool

  # If you have jq installed, you can get the certnames by piping to jq with
  # the below query:
  # https://${PUPPETDB}:8081/pdb/query/v4/nodes | /vagrant/jq '.[].certname'

  # VERSION 3 QUERY ENDPOINT BELOW
  # https://${PUPPETDB}:8081/v3/nodes
