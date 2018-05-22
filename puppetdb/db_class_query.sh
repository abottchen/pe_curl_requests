#!/bin/bash

su - pe-postgres -s /bin/bash -c "/opt/puppetlabs/server/bin/psql -d pe-classifier -c \"select * from classes\"" > /tmp/classes.txt
