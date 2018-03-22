#!/bin/bash

# Get the number of resource events for each node that is not a managed resource. Typically recursive file or tidy files. Useful for looking for a large resource_events table. 

puppet query 'events[certname, count()] { (!resource_title in resources[title]{}) group by certname }'
