#!/bin/bash
#
# This script retrieves a catalog from Puppet's catalog endpoint by generating
#   and submitting Facter facts from the current node. 
#
# https://docs.puppet.com/puppet/latest/http_api/http_catalog.html
#

# Either set the MASTER environmental variable at the command line to use
# a custom server, or let the script automatically try the FQDN of the node
# running the script
SET_SERVER=$(hostname -f)
MASTER="${MASTER:-$SET_SERVER}"


curl -X POST \
  --cert $(puppet config print hostcert) \
  --key $(puppet config print hostprivkey) \
  --cacert $(puppet config print cacert) \
  https://$MASTER:8140/puppet/v3/catalog/$MASTER?environment=production \
  --data-urlencode 'facts_format=pson' \
  --data-urlencode "facts=$(/opt/puppetlabs/puppet/bin/ruby -rcgi -e "puts CGI.escape('$(puppet facts find --render-as json)')")"


