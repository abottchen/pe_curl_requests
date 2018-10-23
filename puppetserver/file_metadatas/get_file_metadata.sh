#!/bin/bash
# Get the metadata for a specific file.
# This example gets the file metadata for a fact.
# Note: this checks the aio_agent_version.rb fact in the production environment. 
# You can sub `plugins/facter` for `modules/<modulename>/<filename>` to check the metadata for a file in a module.

curl --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey) --cacert $(puppet config print localcacert) "https://$(puppet config print server):8140/puppet/v3/file_metadata/plugins/facter/aio_agent_version.rb?environment=production" | python -m json.tool
