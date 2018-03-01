#!/bin/bash

curl -k -v -X POST -H "Content-Type: application/json" "https://$(hostname -f):8170/code-manager/v1/webhook?type=gitlab&token=$(cat ~/.puppetlabs/token)" -d '{ "ref": "refs/heads/production" }'
