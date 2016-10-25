#!/bin/sh

curl -k -H "X-Authentication:$(cat ~/.puppetlabs/token)" https://$(hostname -f):8143/orchestrator/v1/command/deploy -X POST -d '{"environment":"production"}' -H "Content-Type: application/json"
