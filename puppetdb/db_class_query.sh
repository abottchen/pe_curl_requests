#!/bin/bash

su - pe-postgres -s /bin/bash -c "/opt/puppet/bin/psql -d pe-classifier -c \"select * from classes\"" > /tmp/classes.txt
