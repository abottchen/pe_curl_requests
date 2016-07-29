#!/bin/sh

curl -k https://localhost:8140/status/v1/services?level=debug > /tmp/$(hostname).json
