# Troubleshooting


- local troubleshooting
- composer troubleshooting
- vagrant troubleshooting



## Local Troubleshooting

### Local login

ssh into vagrant box
```
vagrant ssh
```



### apache


Ensure apache is running worker should output worker
```
a2query -M
```

### php

```
which php
whereis php
```

### /usr/local/bin

```
12:27 AM]-[vagrant@vagrant]-[/usr/local/bin]
$ ll
total 41124
drwxr-xr-x 2 vagrant vagrant     4096 Jun  2 23:39 cache/
lrwxrwxrwx 1 vagrant root          46 Jun  2 23:39 cleancss -> ../lib/node_modules/clean-css-cli/bin/cleancss*
lrwxrwxrwx 1 vagrant vagrant       48 Jun  3 00:04 codecept -> /vagrant/vendor/codeception/codeception/codecept*
-rwxr-xr-x 1 vagrant root         604 Jun  2 23:41 compass*
-rwxr-xr-x 1 vagrant root         662 Jun  2 23:41 compass-validate*
-rwxr-xr-x 1 vagrant vagrant  1849094 Jun  2 23:39 composer*
lrwxrwxrwx 1 vagrant vagrant       77 Jun  3 00:04 composer-require-checker -> /vagrant/vendor/maglnet/composer-require-checker/bin/composer-require-checker*
lrwxrwxrwx 1 vagrant vagrant       49 Jun  3 00:04 infection -> /vagrant/vendor/infection/infection/bin/infection*
lrwxrwxrwx 1 vagrant root          34 Jun  2 23:39 lessc -> ../lib/node_modules/less/bin/lessc*
lrwxrwxrwx 1 vagrant vagrant       47 Jun  3 00:04 pdepend -> /vagrant/vendor/pdepend/pdepend/src/bin/pdepend*
lrwxrwxrwx 1 vagrant vagrant       30 Jun  3 00:03 phan -> /vagrant/vendor/phan/phan/phan*
lrwxrwxrwx 1 vagrant vagrant       37 Jun  3 00:03 phan_client -> /vagrant/vendor/phan/phan/phan_client*
-rwxr-xr-x 1 vagrant vagrant 38346752 Jun  3 00:23 phantomjs*
lrwxrwxrwx 1 vagrant vagrant       52 Jun  3 00:04 phpcbf -> /vagrant/vendor/squizlabs/php_codesniffer/bin/phpcbf*
lrwxrwxrwx 1 vagrant vagrant       50 Jun  3 00:04 phpcf -> /vagrant/vendor/wapmorgan/php-code-fixer/bin/phpcf*
lrwxrwxrwx 1 vagrant vagrant       51 Jun  3 00:04 phpcs -> /vagrant/vendor/squizlabs/php_codesniffer/bin/phpcs*
lrwxrwxrwx 1 vagrant vagrant       54 Jun  3 00:02 php-cs-fixer -> /vagrant/vendor/friendsofphp/php-cs-fixer/php-cs-fixer*
lrwxrwxrwx 1 vagrant vagrant       41 Jun  3 00:04 phpmd -> /vagrant/vendor/phpmd/phpmd/src/bin/phpmd*
lrwxrwxrwx 1 vagrant vagrant       52 Jun  3 00:04 phpmetrics -> /vagrant/vendor/phpmetrics/phpmetrics/bin/phpmetrics*
lrwxrwxrwx 1 vagrant vagrant       46 Jun  3 00:04 php-parse -> /vagrant/vendor/nikic/php-parser/bin/php-parse*
lrwxrwxrwx 1 vagrant vagrant       43 Jun  3 00:04 phpspec -> /vagrant/vendor/phpspec/phpspec/bin/phpspec*
lrwxrwxrwx 1 vagrant vagrant       43 Jun  3 00:04 phpstan -> /vagrant/vendor/phpstan/phpstan/bin/phpstan*
lrwxrwxrwx 1 vagrant vagrant       39 Jun  3 00:04 phpunit -> /vagrant/vendor/phpunit/phpunit/phpunit*
-rwxr-xr-x 1 vagrant root         586 Jun  2 23:41 sass*
-rwxr-xr-x 1 vagrant root         602 Jun  2 23:41 sass-convert*
-rwxr-xr-x 1 vagrant root         586 Jun  2 23:41 scss*
lrwxrwxrwx 1 vagrant vagrant       60 Jun  3 00:04 security-checker -> /vagrant/vendor/sensiolabs/security-checker/security-checker*
lrwxrwxrwx 1 vagrant vagrant       38 Jun  3 00:03 tocheckstyle -> /vagrant/vendor/phan/phan/tocheckstyle*
lrwxrwxrwx 1 vagrant root          42 Jun  2 23:39 uglifyjs -> ../lib/node_modules/uglify-js/bin/uglifyjs*
lrwxrwxrwx 1 vagrant vagrant       54 Jun  3 00:04 unused_scanner -> /vagrant/vendor/insolita/unused-scanner/unused_scanner*
lrwxrwxrwx 1 vagrant vagrant       64 Jun  3 00:04 wkhtmltoimage-amd64 -> /vagrant/vendor/h4cc/wkhtmltoimage-amd64/bin/wkhtmltoimage-amd64*
lrwxrwxrwx 1 vagrant vagrant       60 Jun  3 00:04 wkhtmltopdf-amd64 -> /vagrant/vendor/h4cc/wkhtmltopdf-amd64/bin/wkhtmltopdf-amd64*
```


## Composer troubleshooting

### Composer

```
composer diagnose
composer install -vvv
```


## Vagrant troubleshooting


### Error while executing VBoxManage

**Failed to open/create the internal network Vagrant on Windows10**


error message:
```
==> hklocal: Booting VM...
There was an error while executing `VBoxManage`, a CLI used by Vagrant
for controlling VirtualBox. The command and stderr is shown below.

Command: ["startvm", "0ebafdff-3c78-4081-bf97-b76021b37004", "--type", "headless"]

Stderr: VBoxManage.exe: error: Failed to open/create the internal network 'HostInterfaceNetworking-VirtualBox Host-Only Ethernet Adapter' (VERR_INTNET_FLT_IF_NOT_FOUND).
VBoxManage.exe: error: Failed to attach the network LUN (VERR_INTNET_FLT_IF_NOT_FOUND)
VBoxManage.exe: error: Details: code E_FAIL (0x80004005), component ConsoleWrap, interface IConsole
```


**Solution**

- Open Windows Network Connections
- Right click on VirtualBox Host only adapter that created
- Choose properties
- Check "VirtualBox NDIS6 Bridged Networking driver"
- disable and Enable the adapter

<img alt="Image" src="http://i.stack.imgur.com/Tkkws.png">

source: http://stackoverflow.com/questions/33725779/failed-to-open-create-the-internal-network-vagrant-on-windows10




### "vboxsf" is not available

Vagrant was unable to mount VirtualBox shared folders. This is usually
because the filesystem "vboxsf" is not available.

**solution**
```
vagrant plugin install vagrant-vbguest
vagrant reload
```


see: http://stackoverflow.com/a/23752848


### Running vagrant as admin

Ensure `idea.exe` is running as admin (right click > Compatibility > Run this program as an administrator) 



### NFS problems

**Inappropriate ioctl for device**
```
mesg: ttyname failed: Inappropriate ioctl for device
```
see 
- https://github.com/geerlingguy/drupal-vm/issues/681
- https://github.com/mitchellh/vagrant/issues/7155
- https://github.com/mitchellh/vagrant/issues/6871


**mount.nfs: access denied**
```
mount.nfs: access denied by server while mounting 192.168.56.1
```


### Also see

see https://github.com/mitchellh/vagrant/issues/6871
see https://github.com/mitchellh/vagrant/issues/7155
