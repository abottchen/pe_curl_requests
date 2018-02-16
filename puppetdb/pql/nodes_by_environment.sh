#!/bin/bash

puppet query 'nodes[certname] { report_environment = "production" }'
