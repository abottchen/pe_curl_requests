#!/bin/bash

curl -X PUT https://$(puppet config print certname):4433/rbac-api/v1/ds --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey) --cacert $(puppet config print cacert) -d "@/vagrant/ds-stuff/ds.json" -H 'Content-Type: application/json'
