#!/bin/bash

ldapsearch -LLL -x -h pe-381-agent-win2008.puppetdebug.vlan -D "cn=testadmin,cn=Users,dc=puppetdebug,dc=vlan" -W -b "dc=puppetdebug,dc=vlan" "(&(objectClass=*)(sAMAccountName=testadmin))"
