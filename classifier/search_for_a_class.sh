#!/bin/bash
# This script searches the puppetserver API for all known classes that match ^pe_.*
# Adjust the search pattern to tailor this script to your particular search pattern.

SET_SERVER=$(puppet config print server)
CONSOLE="${CONSOLE:-$SET_SERVER}"

# Set variables for the curl.
CERT="/etc/puppetlabs/puppet/ssl/certs/$(puppet config print certname).pem"
KEY="/etc/puppetlabs/puppet/ssl/private_keys/$(puppet config print certname).pem"
CACERT="/etc/puppetlabs/puppet/ssl/certs/ca.pem"

/opt/puppetlabs/puppet/bin/curl -s -X GET \
                                --header "Content-Type: application/json" \
                                --cert   "$CERT" \
                                --key    "$KEY" \
                                --cacert "$CACERT" \
                                "https://${CONSOLE}:8140/puppet/v3/resource_types/^pe_.*?environment=production&kind=class" | python -m json.tool | grep \"name\"

