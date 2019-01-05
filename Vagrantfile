# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.


  #
  # * VAGRANT BASE BOX
  #
  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  # config.vm.box = "base"
  # config.vm.box = "ubuntu/bionic64"
  config.vm.box = "bento/ubuntu-18.04"
  # config.vm.box = "geerlingguy/ubuntu1804"


  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false


  #
  # * NETWORK IP ADDRESS
  #
  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", :ip => '192.168.56.184'

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"


  #
  # * SYNCED FOLDER
  #
  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  #
  # * Use NFS share (multi-OS friendly)
  # * FASTER VAGRANT:
  # * - see https://blog.theodo.fr/2017/07/speed-vagrant-synced-folders/
  # * - see https://www.jverdeyen.be/vagrant/speedup-vagrant-nfs/
  #
  config.vm.synced_folder ".", "/vagrant", type: "nfs",
                           mount_options: ['rw', 'vers=3', 'tcp'],
                           linux__nfs_options: ['rw', 'no_subtree_check', 'all_squash', 'async']
  # vers=3    specifies version 3 of the NFS protocol to use
  # tcp       specifies for the NFS mount to use the TCP protocol.
  # fsc       will make NFS use FS-Cache
  # actimeo=2 absolute time for which file and directory entries are kept in the file-attribute cache after an update
  # mount_options: ['rw', 'vers=3', 'tcp', 'fsc', 'actimeo=2'],
  # linux__nfs_options: ['rw', 'no_subtree_check', 'all_squash', 'async']


  # see http://stackoverflow.com/a/23887366
  config.nfs.map_uid = Process.uid
  config.nfs.map_gid = Process.gid
  #
  # * Alternatively use SMB share
  # * - Comment out nfs share
  # * - Run vagrant as administrator (eg. run intellij as administrator or cmd/powershell as admin)
  # * - Will ask for your windows login and password (after "Sharing SMB Folders...")
  #
  # config.vm.synced_folder ".", "/vagrant",
  #                         SharedFoldersEnableSymlinksCreate: true,
  #                         :group => 'www-data',
  #                         :owner => 'vagrant',
  #                         :mount_options => ['dir_mode=0777', 'file_mode=0777'],
  #                         :type => 'smb'


  #
  # * PROVIDER
  #
  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.
  config.vm.provider 'virtualbox' do |v|
    v.name = 'serverbuild-1804'
    v.customize ['modifyvm', :id, '--cpuexecutioncap', '99']
    v.memory = 5120
    v.cpus = 2
  end


  #
  # * PROVISION
  #
  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
  #
  config.vm.provision "shell", inline: <<-SHELL
    #export DEBIAN_FRONTEND=noninteractive
    #apt-get -y update
    #apt-get -y upgrade
    #apt-get -y install puppet
  SHELL
  config.vm.provision "shell", path: "www/scripts/server_package_update.sh"

  # Enable the Puppet provisioner, with will look in manifests
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'www/puppet/manifests'
    puppet.manifest_file = 'local.pp'
    puppet.module_path = 'www/puppet/modules'
  end

  # avoid "stdin: is not a tty" message. See http://goo.gl/Zjs8VT
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
end
