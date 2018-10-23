#!/bin/sh

puppet query 'resources[certname]{ tag = "puppet_enterprise::profile::master" group by certname}'
