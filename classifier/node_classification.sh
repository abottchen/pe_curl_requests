#!/bin/bash
curl -X POST --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey) --cacert $(puppet config print cacert) https://$(grep server /etc/puppetlabs/puppet/classifier.yaml |cut -d" " -f 2):4433/classifier-api/v1/classified/nodes/pe-201612-agent.puppetdebug.vlan -H "Content-Type: application/json"
