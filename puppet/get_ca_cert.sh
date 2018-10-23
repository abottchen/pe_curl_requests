#!/bin/bash
#
# This script gets the Puppet CA certificate from your Puppet master.
#
# https://puppet.com/docs/puppet/5.3/http_api/http_certificate.html
#

# Either set the MASTER environmental variable at the command line to use
# a custom server, or let the script automatically try the FQDN of the node
# running the script
SET_SERVER=$(hostname -f)
MASTER="${MASTER:-$SET_SERVER}"

curl -k "https://${MASTER}:8140/puppet-ca/v1/certificate/ca"
