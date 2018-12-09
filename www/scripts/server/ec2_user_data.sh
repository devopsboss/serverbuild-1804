#!/usr/bin/env bash

# USAGE:
# sudo /vagrant/www/scripts/server/ec2_user_data.sh


sudo apt-get update -y
sudo apt-get install -y puppet
sudo apt-get awscli -y puppet
