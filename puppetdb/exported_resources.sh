# Use the reference form of any resource type you want to query for.

SET_SERVER=$(puppet config print server)
CONSOLE="${CONSOLE:-$SET_SERVER}"

curl -G -H  "Accept: application/json"            \
  'http://${CONSOLE}:8080/pdb/query/v4/resources'  \
  --data-urlencode 'query=["=","exported", true]' | jgrep "type=Host"
