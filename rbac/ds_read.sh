#!/bin/bash

curl https://$(puppet config print certname):4433/rbac-api/v1/ds --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey) --cacert $(puppet config print cacert)
