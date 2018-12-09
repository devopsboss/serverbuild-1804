# Appserver 1804 - staging

## Server build from fresh EC2

Build new server:
```bash
sudo mkdir -p /var/serverbuild-1804/projects && cd /var/serverbuild-1804/projects && sudo chown -R ubuntu:www-data /var/serverbuild-1804/projects 
git clone https://mattyhansen@bitbucket.org/neosen/serverbuild-1804.git
# enter github credentials to clone server build repo, then run puppet apply...
cd /var/serverbuild-1804/projects/serverbuild-1804 && git checkout master
/var/serverbuild-1804/projects/serverbuild-1804/www/scripts/server/staging/puppet_apply.sh
```

## Server update for existing EC2

Update exiting server:
```bash
/var/serverbuild-1804/projects/serverbuild-1804/www/scripts/server/staging/server_package_update.sh
```

## Troubleshooting 


#### debug puppet apply
```bash
/var/serverbuild-1804/projects/serverbuild-1804/www/scripts/server/staging/puppet_apply_debug.sh
```
