#!/bin/bash
# Get the timestamp of the last class update in the Node Classifier.
# This can be run from any Puppet Master or the Puppet Console.
# https://docs.puppetlabs.com/pe/latest/nc_last_class_update.html

CONFDIR="$(puppet master --configprint confdir)"

CERT="$(puppet master   --confdir "${CONFDIR}" --configprint hostcert)"
CACERT="$(puppet master --confdir "${CONFDIR}" --configprint localcacert)"
PRVKEY="$(puppet master --confdir "${CONFDIR}" --configprint hostprivkey)"
OPTIONS="--cert ${CERT} --cacert ${CACERT} --key ${PRVKEY}"
SET_SERVER=CONSOLE="$(awk '/server: /{print $NF}' "${CONFDIR}/classifier.yaml")"
CONSOLE="${CONSOLE:-$SET_SERVER}"

/opt/puppetlabs/puppet/bin/curl -s -X GET $OPTIONS "https://${CONSOLE}:4433/classifier-api/v1/last-class-update" | python -m json.tool

