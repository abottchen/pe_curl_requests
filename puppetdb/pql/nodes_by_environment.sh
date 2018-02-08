#!/bin/bash

puppet query 'nodes[certname^C{ report_environment = "production" }'
