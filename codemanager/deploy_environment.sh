# Make sure you generate a token with puppet access beforehand
# Show credentials with:  `puppet access show`
# puppet access login --service-url https://<HOSTNAME OF PUPPET ENTERPRISE CONSOLE>:4433/rbac-api --lifetime 180d

SET_SERVER=$(puppet config print server)
CODE_MANAGER="${CODE_MANAGER:-$SET_SERVER}"

curl -k -X POST -H 'Content-Type: application/json' \
  -H "X-Authentication: `cat ~/.puppetlabs/token`" \
  "https://${CODE_MANAGER}:8170/code-manager/v1/deploys" \
  -d '{"environments": ["production"], "wait": true}'
