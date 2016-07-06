#!/bin/sh
curl -X POST  -H "Content-type: application/json"  \
> --data \
> '{
>     "name": "couch_demo_2",
>     "classes": {"ntp": {}},
>     "environment": "production",
>     "environment_trumps": false,
>     "parent": "00000000-0000-4000-8000-000000000000",
>     "rule": [
>       "and",
>       [
>            "~",
>            [
>                "fact",
>                "pe_version"
>            ],
>            ".+"
>       ]
>      ],
>     "variables": {"foo": "bar"}
> }' \
> --cert   $(puppet config print hostcert) \
> --key    $(puppet config print hostprivkey) \
> --cacert $(puppet config print localcacert) \
>  https://$(puppet config print server):4433/classifier-api/v1/groups/e90dc676-2031-446f-9d4b-21d017392a4d
