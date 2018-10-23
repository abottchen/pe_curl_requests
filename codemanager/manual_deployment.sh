#!/bin/bash
#
# This script can be run to manually trigger Code Manager to deploy code from your control-repo. This sort of
# thing is neccesary when, for example:
#   - You've turned on Code Manager but have not yet made an RBAC token.
#   - You want to pull down the latest version of a Puppetfile module without pushing to your GMS.
#   - Something has broken the post-receive hook on your GMS that would've triggered Code Manager.
#   - Syntax errors in your Puppetfile prevent you from retrieving those fixes to that Puppetfile.
#   - Puppetserver has crashed due to file-sync issues between code and code-staging.

[[ $EUID -eq 0 ]] || { echo "${0##*/} must be run as root or with sudo" >&2; exit 1; }

echo "==> Fixing permissions on the code-staging directory"
chown -R pe-puppet:pe-puppet /etc/puppetlabs/code-staging

echo "==> Running r10k manually as pe-puppet to fetch new code"
sudo -u pe-puppet bash -c '/opt/puppetlabs/puppet/bin/r10k deploy environment -c /opt/puppetlabs/server/data/code-manager/r10k.yaml -p -v debug'

deploy_result=$?
[[ $deploy_result -eq 0 ]] || { echo -e "\nR10k failed to deploy your code. Check the scroll-back for errors.\n" >&2; exit 1; }

echo "==> Delete environments in the code-dir so file-sync can do its thing"
rm -rf /etc/puppetlabs/code/*

echo "==> Fixing permissions on the code directory"
chown pe-puppet:pe-puppet /etc/puppetlabs/code

echo "==> Starting pe-puppetserver"
/opt/puppetlabs/puppet/bin/puppet resource service pe-puppetserver ensure=running

# Set variables for the curl.
CERT="$(puppet agent --configprint hostcert)"
KEY="$(puppet agent --configprint hostprivkey)"
CACERT="$(puppet agent --configprint localcacert)"
SERVER="$(puppet agent --configprint server)"

echo "==> Hitting the file-sync commit endpoint at https://${SERVER}:8140/file-sync/v1/commit"
/opt/puppetlabs/puppet/bin/curl -v -s --request POST \
  --header "Content-Type: application/json" \
  --data '{"commit-all": true}' \
  --cert "${CERT}" \
  --key "${KEY}" \
  --cacert "${CACERT}" \
  "https://${SERVER}:8140/file-sync/v1/commit" && echo

