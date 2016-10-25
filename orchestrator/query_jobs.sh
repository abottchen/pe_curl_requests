#!/bin/sh

curl -k -H "X-Authentication:$(cat ~/.puppetlabs/token)" https://$(hostname -f):8143/orchestrator/v1/jobs
