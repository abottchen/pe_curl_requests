#!/bin/bash

puppet query 'reports[count(), to_string(receive_time, "YY-MM-DD HH24:MI")]{ group by to_string(receive_tme, "YY-MM-DD HH24:MI")}'

# With JQ to parse into the thundering herd type query:
# puppet query 'reports[count(), to_string(receive_time, "YY-MM-DD HH24:MI")]{ group by to_string(receive_tme, "YY-MM-DD HH24:MI")}' | jq -r -s  '.[] | sort_by(.to_string) | .[] | "\(.to_string)\t\(.count)"'
