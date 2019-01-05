## Remote server build instructions

## Server build from fresh EC2

Build new server:
```bash
cd /srv && git clone https://
# enter github credentials to clone server build repo, then run puppet apply...
cd /srv/serverbuild-1804 && git checkout master
/srv/serverbuild-1804/www/scripts/puppet_apply.sh
```

## Server update for existing EC2

Update exiting server:
```bash
/srv/serverbuild-1804/www/scripts//server_package_update.sh
```

## Troubleshooting 


#### debug puppet apply
```bash
/srv/serverbuild-1804/www/scripts/puppet_apply_debug.sh
```
