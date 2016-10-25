#!/bin/sh
# must be run on localhost to not include certs
curl -s -X GET http://localhost:8080/pdb/query/v4/nodes --data-urlencode 'query=[">",["fact", "fact2"], 2]'

# 3.8 queries

curl -G 'http://localhost:8080/v3/nodes' --data-urlencode 'query=[">", ["fact", "fact1"], 0]'
