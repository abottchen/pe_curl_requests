1. Pull the facts from the target node, for example using ssh: ssh agentnode.puppet.com puppet facts > facts.json. These could also be programmatically pulled from the /pdb/query/v4/facts PDB endpoint using the certname of the target agent as in the query data (https://docs.puppet.com/puppetdb/4.1/api/query/v4/facts.html#pdbqueryv4facts)
2. If using the output of puppet facts, make the data match the schema for the explanation endpoint by removing the "timeout" and "expiration" json entries in the resulting file and renaming "values" to "fact"
3. Post this data into the explanation endpoint:

curl -X POST --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey) --cacert $(puppet config print localcacert) https://$(hostname -f):4433/classifier-api/v1/classified/nodes/vvvbbc6595llm2s.delivery.puppetlabs.net/explanation --data @facts5.json -H "Content-Type: application/json"
