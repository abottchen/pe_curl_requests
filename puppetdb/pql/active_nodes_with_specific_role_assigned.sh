#!/bin/sh
puppet query "resources[certname,title,environment]{ nodes { deactivated is null and report_timestamp > \"$(date -d "2 days ago" +%Y-%m-%dT%H:%M:%S)\" } and title ~ '^Role::Webserver' }"
