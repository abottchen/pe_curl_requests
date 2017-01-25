#!/bin/sh

curl -k -G http://localhost:8080/pdb/query/v4/reports --data-urlencode 'query=["=", "certname", "ud1xe5jynyfg2b0.delivery.puppetlabs.net"]'

# To pull only specific parts of the reports, use the extract parameter:

# curl -k -G http://localhost:8080/pdb/query/v4/reports --data-urlencode 'query=["extract", "certname", ["=", "certname", "ud1xe5jynyfg2b0.delivery.puppetlabs.net"]]'
