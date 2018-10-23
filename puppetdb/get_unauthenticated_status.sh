#!/bin/bash

# NOTE: This must be run FROM the PuppetDB Node as PuppetDB is set, by default,
#       to only accept unauthenticated requests from localhost. That can be changed,
#       however, by changing this setting: https://docs.puppet.com/puppetdb/4.0/configure.html#host
curl -k -X GET -H "Accept: application/json" http://localhost:8080/status/v1/services/puppetdb-status | python -m json.tool
