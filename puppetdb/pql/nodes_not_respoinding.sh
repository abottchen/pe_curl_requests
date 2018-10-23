#!/bin/bash

puppet query "nodes[certname]{deactivated is null and report_timestamp < \"$(date +%Y-%m-%dT%H:%M:%S)\" }"
