#!/bin/bash

# Variables for the console node and the classifier dump file
NC_BACKUP='node_classifier_dump.json'
SET_SERVER=$(puppet config print server)
CONSOLE="${CONSOLE:-$SET_SERVER}"

# Exit if the node classifier backup file isn't found
[[ -f $NC_BACKUP ]] || { echo "Unable to find NC backup: ${NC_BACKUP}" >&2; exit 1; }

# Perform the restore
curl -X POST -H 'Content-Type: application/json' \
  --cert "$(puppet config print hostcert)" \
  --key "$(puppet config print hostprivkey)" \
  --cacert "$(puppet config print localcacert)" \
  -d @$NC_BACKUP \
  "https://${CONSOLE}:4433/classifier-api/v1/import-hierarchy"

