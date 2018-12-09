#!/usr/bin/env bash

# USAGE:
# /vagrant/www/scripts/server/server_package_update.sh
# /var/serverbuild-1804/projects/serverbuild-1804/www/scripts/server/server_package_update.sh


# allow running of 32bit programs (required for 32bit java)
#dpkg --add-architecture i386

#
# * update packages
#
sudo apt-get -y update

#
# * upgrade packages
#
## This makes debconf use a frontend that expects no interactive input at all, preventing it from even trying to access stdin.
## https://serverfault.com/a/670688
#export DEBIAN_FRONTEND=noninteractive
#sudo apt-get -y upgrade
# This makes debconf use a frontend that expects no interactive input at all, preventing it from even trying to access stdin.
DEBIAN_FRONTEND=noninteractive apt-get -o DPkg::options::="--force-confdef" -o DPkg::options::="--force-confold" upgrade -y

#
# * auto remove packages
#
sudo apt-get -y autoremove

#
# * install puppet
#
sudo apt-get -y install puppet
