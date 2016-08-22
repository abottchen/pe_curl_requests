curl http://localhost:8080/v3/nodes/<nodename>/resources --data-urlencode 'query=["and", ["=", "type", "Nagios_host"], ["=", "exported", true]]' 
