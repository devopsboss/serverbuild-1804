## Local server build instructions

### Debug puppet apply

sudo /usr/bin/puppet apply --debug --modulepath=/vagrant/www/puppet/modules /vagrant/www/puppet/manifests/local.pp

### 1) install software

- virtual box
- vagrant
- vagrant vbguest plugin: `vagrant plugin install vagrant-vbguest`
- vagrant nfs plugin: `vagrant plugin install vagrant-winnfsd` 


### 2) update hosts file

```
## appserver 1804
192.168.56.184 serverbuild-1804.localdev
```


### 3) www/projects expected folders 


### 4) vagrant up

Run `vagrant up` to create local server


### 5) setup assets & database

Run `./start.sh` (or `./start.bat`)


### 5) ensure projects are working

- http://serverbuild-1804.localdev


## Scripts

### start.sh

vagrant reload --provision
```
./start.sh
OR
./start.bat
```
