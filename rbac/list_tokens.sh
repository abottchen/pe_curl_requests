#!/bin/sh
# There is currently no API to list existing tokens and their expiration dates.  This should be addressed by PE-9890 somewhere down the line
# In the meantime, we can query the DB

su - pe-postgres -s /bin/bash -c "/opt/puppetlabs/server/bin/psql -d pe-rbac -c \"select subjects.login,tokens.expiration FROM subjects LEFT JOIN tokens ON subjects.id = tokens.user_id\""
