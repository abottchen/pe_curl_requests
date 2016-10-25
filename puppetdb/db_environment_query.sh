#!/bin/bash

su - pe-postgres -s /bin/bash -c "/opt/puppet/bin/psql -d pe-classifier -c \"select * from environments\"" > /tmp/environments.txt
