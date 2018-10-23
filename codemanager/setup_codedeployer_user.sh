#!/bin/bash

# Install rbac_user dependencies to general modulepath
puppet module install pltraining-rbac --version 0.0.4 --target-dir /etc/puppetlabs/code/modules/
puppet module install puppetlabs-stdlib  --target-dir /etc/puppetlabs/code/modules/
puppet module install abrader-gms --version 1.0.2 --target-dir /etc/puppetlabs/code/modules/

# Assign the declaration to $CODE
# NOTE: The 'Code Deployers' role is NEW to Puppet Enterprise 2016.4.x
#       If you're using an older version, you'll need to create the role
#       and then assign it to this user. For more help see:
#       https://github.com/npwalker/pe_code_manager_webhook/blob/master/manifests/code_manager.pp
read -r -d '' CODE <<-'EOF'
  rbac_user { 'codedeployer' :
    ensure       => 'present',
    name         => 'codedeployer',
    email        => 'codedeployer@example.com',
    display_name => 'Code Manager Service Account',
    password     => 'puppetlabs',
    roles        => [ 'Code Deployers' ],
  }
EOF

# Puppet apply FTW!
puppet apply -e "${CODE}"
