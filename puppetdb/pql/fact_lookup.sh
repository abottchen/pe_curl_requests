#!/bin/bash

puppet query 'facts[value] { name = "domain" and certname = "pe-201735-agent.puppetdebug.vlan" }'
