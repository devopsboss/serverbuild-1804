#!/usr/bin/env bash

# USAGE:
# /srv/serverbuild-1804/www/scripts/puppet_apply_debug.sh
# /vagrant/www/scripts/puppet_apply_debug.sh


if [[ -n "$1" ]]; then
MANIFEST_NAME=$1
else
    echo "Provide MANIFEST_NAME eg. puppet_apply_debug.sh staging"
    exit
fi

echo "update server packages"
/srv/serverbuild-1804/www/scripts/server/server_package_update.sh

echo "run puppet apply"
cd /srv/serverbuild-1804/www/puppet/manifests && sudo /usr/bin/puppet apply --debug --modulepath=/srv/serverbuild-1804/www/puppet/modules ${MANIFEST_NAME}.pp

