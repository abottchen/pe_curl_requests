#!/bin/bash

su - pe-postgres -s /bin/bash -c "/opt/puppetlabs/server/bin/psql -d pe-classifier -c \"select * from environments\"" > /tmp/environments.txt
