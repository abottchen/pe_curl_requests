#!/bin/bash

puppet query 'nodes[certname]{ !certname in facts[certname]{ name = "myfact"} }'
