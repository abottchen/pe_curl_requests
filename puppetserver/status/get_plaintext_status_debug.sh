# puppet_enterprise::profile::console::console_services_plaintext_status_enabled must be set to true
# in console, PE Console group, puppet_enterprise::profile::console class, console_services_plaintext_status_enabled

SET_SERVER=$(puppet config print server)
CONSOLE="${CONSOLE:-$SET_SERVER}"

curl -X GET \
  --data-urlencode 'level=debug' \
  http://${CONSOLE}:8123/status/v1/services | python -m json.tool
