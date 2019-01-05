#!/usr/bin/env bash

# USAGE
# /srv/serverbuild-1804/www/scripts/puppet_apply.sh
# /vagrant/www/scripts/puppet_apply.sh


if [[ -n "$1" ]]; then
MANIFEST_NAME=$1
else
    echo "Provide MANIFEST_NAME eg. puppet_apply.sh staging"
    exit
fi

echo "update server packages"
/srv/serverbuild-1804/www/scripts/server_package_update.sh

echo "run puppet apply"
cd /srv/serverbuild-1804/www/puppet/manifests && sudo /usr/bin/puppet apply --modulepath=/srv/serverbuild-1804/www/puppet/modules ${MANIFEST_NAME}.pp
