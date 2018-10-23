#!/bin/bash
# Quick way to test out puppet SSL connections that are giving crazy ssl errors,
# adapted from http://www.masterzen.fr/2010/11/14/puppet-ssl-explained/ to not 
# need you to type any paths. Ctrl+f to send a request. Thanks to Ben Ford from 
# Puppet.com for putting me on to this! 
#
# Monitor the output of the command carefully!  The slightest error or warning
# can mean that something is screwing up your SSL converstation, eg I had
# 
#   2251144968090600:error:140790E5:SSL routines:SSL23_WRITE:ssl handshake 
#   failure:s23_lib.c:177:
#
# Which turned out to be a load-balancer downgrading or otherwise messing with
# the SSL conversation... (workaround was to bypass/fix will be to upgrade or
# reconfigure)

PATH=/opt/puppetlabs/puppet/bin:$PATH
openssl s_client -host $(puppet config print server) -port 8140 -cert $(puppet config print certdir)/$(puppet config print certname).pem -key $(puppet config print privatekeydir)/$(puppet config print certname).pem -CAfile $(puppet config print certdir)/ca.pem
