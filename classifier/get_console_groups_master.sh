#!/bin/bash
# This command will pull the console node from the classifier.yaml file, so it can always be run on the master without worrying about the customer mixing up the target system
curl https://$(grep server /etc/puppetlabs/puppet/classifier.yaml |cut -d" " -f 2):4433/classifier-api/v1/groups --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey)  --cacert $(puppet config print localcacert) -H "Content-Type: application/json" | python -m json.tool
