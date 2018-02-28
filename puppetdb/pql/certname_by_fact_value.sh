#!/bin/bash

puppet query 'facts[certname] { name = "domain" and value = "puppetdebug.vlan" }'
