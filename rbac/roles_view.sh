#!/bin/bash
#
# Show the current RBAC roles that are in the PE console
# https://docs.puppet.com/pe/latest/rbac_roles_v1.html#get-roles
#
[[ -f ~/.puppetlabs/token ]] || { echo 'No token found. Please authenticate with "puppet access login" first.' >&2; exit 1; }

AUTH_TOKEN="$(<~/.puppetlabs/token)"
OPTIONS="-H X-Authentication:${AUTH_TOKEN}"
SET_SERVER=$(puppet agent --configprint server)
CONSOLE="${CONSOLE:-$SET_SERVER}"

/opt/puppetlabs/puppet/bin/curl -s -X GET $OPTIONS "https://${CONSOLE}:4433/rbac-api/v1/roles" | python -m json.tool
