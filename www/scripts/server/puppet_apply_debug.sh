#!/usr/bin/env bash

# /var/serverbuild-1804/projects/serverbuild-1804/www/scripts/server/puppet_apply_debug.sh


if [[ -n "$1" ]]; then
MANIFEST_NAME=$1
else
    echo "Provide MANIFEST_NAME eg. puppet_apply_debug.sh staging"
    exit
fi

echo "update server packages"
/var/serverbuild-1804/projects/serverbuild-1804/www/scripts/server/server_package_update.sh

echo "run puppet apply"
cd /var/serverbuild-1804/projects/serverbuild-1804/www/puppet/manifests && sudo /usr/bin/puppet apply --debug --modulepath=/var/serverbuild-1804/projects/serverbuild-1804/www/puppet/modules ${MANIFEST_NAME}.pp

