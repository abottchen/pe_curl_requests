#!/bin/bash
# This script searches PuppetDB's events endpoint for all events between a set
# time period (24 hours before right now and 24 hours after right now).

SET_SERVER=$(puppet config print server)
PUPPETDB="${PUPPETDB:-$SET_SERVER}"

# Get appropriately formatted timestamps
# NOTE: this command won't run on BSD `date` because of the -I argument,
#       so ensure GNU date is around.
#
# Here's the manpage on the -I argument:
#  -I[FMT], --iso-8601[=FMT]
#    output  date/time  in  ISO  8601  format.   FMT='date'  for  date  only (the
#    default), 'hours', 'minutes', 'seconds', or 'ns' for date and  time  to  the
#    indicated precision.  Example: 2006-08-14T02:34:56-0600
#
TOMORROW=`date -d '+1 day' -Isec`
YESTERDAY=`date -d '-1 day' -Isec`

# Other individual queries...
#--data-urlencode "query=[\">\", \"run_end_time\", \"${YESTERDAY}\"]" \
#--data-urlencode "query=[\"<\", \"run_end_time\", \"${TOMORROW}\"]" \

curl -X GET \
  --tlsv1 \
  --data-urlencode "query=[\"and\", [\">\", \"run_end_time\", \"${YESTERDAY}\"], [\"<\", \"run_end_time\", \"${TOMORROW}\"]]" \
  --cert   $(puppet config print hostcert) \
  --key    $(puppet config print hostprivkey) \
  --cacert $(puppet config print localcacert) \
  https://${PUPPETDB}:8081/pdb/query/v4/events | python -m json.tool
