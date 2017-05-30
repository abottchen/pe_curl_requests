#!/bin/bash

curl -k https://$(hostname -f):8143/orchestrator/v1/inventory -H "X-Authentication:$(cat ~/.puppetlabs/token)"
