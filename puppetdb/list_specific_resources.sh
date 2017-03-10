#!/bin/bash

curl -G -X GET http://$(hostname -f):8080/pdb/query/v4/resources --data-urlencode 'query=["=","type", "File"]' | python -m json.tool > /tmp/file-resources.txt
