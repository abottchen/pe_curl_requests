#!/bin/bash
curl -X GET http://localhost:8080/pdb/query/v4/nodes/$(hostname -f)
