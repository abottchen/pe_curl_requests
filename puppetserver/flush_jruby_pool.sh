#!/bin/sh
# This is useful when updating puppet module code under /opt.  Since that code is read into the active jruby memory space during pe-puppetserver startup,
# flushing the pool prevents you from having to restart the service (which takes forever)

curl -i --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey)  --cacert $(puppet config print localcacert) -X DELETE https://$(hostname -f):8140/puppet-admin-api/v1/jruby-pool
