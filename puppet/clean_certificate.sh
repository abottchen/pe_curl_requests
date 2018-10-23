#!/bin/bash
#
# To emulate a `puppet cert clean <NODE>` using the API, we do 2 operations:
#   1. PUT (SAVE) with a desired_state of 'revoked'
#   2. DELETE
#
# https://docs.puppet.com/puppet/4.5/reference/http_api/http_certificate_status.html
#
# To authenticate with a certficate other than pe-internal-dashboard, you must
# add that certificate name to auth.conf's certificate_status rule on the CA.
#

SET_SERVER=$(puppet config print ca_name | sed 's/^.*\s//')
CA="${CA:-$SET_SERVER}"
NODE='test_node.puppet.vm'

curl -X PUT \
  -H       "Content-Type: text/pson" \
  --data   '{"desired_state":"revoked"}' \
  --silent \
  --tlsv1  \
  --cert   /etc/puppetlabs/puppet/ssl/certs/pe-internal-dashboard.pem \
  --key    /etc/puppetlabs/puppet/ssl/private_keys/pe-internal-dashboard.pem \
  --cacert /etc/puppetlabs/puppet/ssl/certs/ca.pem \
  https://${CA}:8140/puppet-ca/v1/certificate_status/${NODE}?environment=production | python -m json.tool

curl -X DELETE \
  --tlsv1  \
  --silent \
  --cert   /etc/puppetlabs/puppet/ssl/certs/pe-internal-dashboard.pem \
  --key    /etc/puppetlabs/puppet/ssl/private_keys/pe-internal-dashboard.pem \
  --cacert /etc/puppetlabs/puppet/ssl/certs/ca.pem \
  https://${CA}:8140/puppet-ca/v1/certificate_status/${NODE}?environment=production | python -m json.tool

# View cert status. After cleaninig, it should be "not found".
#curl -X GET \
#  --tlsv1  \
#  --cert   /etc/puppetlabs/puppet/ssl/certs/pe-internal-dashboard.pem \
#  --key    /etc/puppetlabs/puppet/ssl/private_keys/pe-internal-dashboard.pem \
#  --cacert /etc/puppetlabs/puppet/ssl/certs/ca.pem \
#  https://${CA}:8140/puppet-ca/v1/certificate_status/${NODE}?environment=production

