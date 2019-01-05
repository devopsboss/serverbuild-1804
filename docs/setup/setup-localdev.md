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
## serverbuild 1804
github192.168.56.184 develop.dashboard-1804.localdev
github192.168.56.184 www.dashboard-1804.localdev
github192.168.56.184 kibana.dashboard-1804.localdev
github192.168.56.184 rabbitmq.dashboard-1804.localdev
```


### 3) www/projects expected folders 


### 4) vagrant up

Run `vagrant up` to create local server


### 5) Sites

- develop.dashboard-1804.localdev  pw = (devops, strongpassword)
- www.dashboard-1804.localdev      pw = (devops, strongpassword)
- rabbitmq.dashboard-1804.localdev pw = (mq_user, strongpassword)
- kibana.dashboard-1804.localdev




## Scripts

### start.sh

```
vagrant reload --provision
```