#!/bin/bash

# All 'colorize' packages in Package Inventory:
# puppet query "package_inventory {package_name = 'colorize'}

# All 'colorize' packages managed by Puppet:
# puppet query "resources {type = 'Package' and title = 'colorize'}"

# All 'colorize' packages not managed by Puppet in Package Inventory:
puppet query "package_inventory {package_name = 'colorize' and ! certname in resources[certname]{type = 'Package' and title = 'colorize'} }"
