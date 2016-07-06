#!/bin/sh

curl -X GET http://localhost:8080/pdb/query/v4/resources | python -m json.tool
