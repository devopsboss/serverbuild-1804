#!/usr/bin/env bash

# USAGE:
# sudo /srv/serverbuild-1804/www/scripts/ec2_user_data.sh
# sudo /vagrant/www/scripts/ec2_user_data.sh


sudo apt-get update -y
sudo apt-get install -y puppet
sudo apt-get awscli -y puppet
#TODO: create devops user
#TODO: download github ssh key
#TODO: clone server build repo
#TODO: run puppet apply