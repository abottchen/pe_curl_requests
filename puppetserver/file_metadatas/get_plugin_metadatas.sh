#!/bin/bash
# A query to simulate what plugin sync will call to get the file metadatas for plugin sync.
# Note: You can specify the environment in the command, which defaults to production

curl --cert $(puppet config print hostcert) --key $(puppet config print hostprivkey) --cacert $(puppet config print localcacert) "https://$(puppet config print server):8140/puppet/v3/file_metadatas/plugins?environment=production&links=follow&recurse=true&source_permissions=ignore&ignore=.svn&ignore=CVS&ignore=.git&ignore=.hg&checksum_type=md5" | python -m json.tool
