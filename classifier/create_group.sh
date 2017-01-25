# Create a group for one specific node and create variables on it.

curl -k -X POST -H 'Content-Type: application/json'  https://$(hostname -f):4433/classifier-api/v1/groups --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey) --cacert $(puppet config print localcacert)  -d '{"classes": {}, "name": "server.puppet.com", "parent": "00000000-0000-4000-8000-000000000000", "rule": ["or", ["=", "name", "server.puppet.com" ] ], "variables": {"var1": "setting1", "var2": "setting2", "var3": false } }'
