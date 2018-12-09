# Class: site_profile
# ===========================
#
# Full description of class site_profile here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'site_profile':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2018 Your name here, unless otherwise noted.
#
class site_profile::ssh::devops_ssh_folder (

) {


  #
  # * ssh folder
  #
  if !defined(Server::Tools::Mkdir['/home/devops/.ssh']) {
    server::tools::mkdir { '/home/devops/.ssh':
      chmod       => '0700',
      owner       => 'devops',
      group       => 'devops',
      requirement => User['devops']
    }
  }

  #
  # * private ssh key
  #
  if !defined(File['/home/devops/.ssh/id_ed25519']) {
    file { '/home/devops/.ssh/id_ed25519':
      ensure => file,
      owner  => 'devops',
      mode   => '0600',
      source => '/vagrant/www/files/dot/devops_ssh/localdev_private_key',
    }
  }

  #
  # * public ssh key
  #
  if !defined(File['/home/devops/.ssh/known_hosts']) {
    file { '/home/devops/.ssh/known_hosts':
      ensure  => file,
      owner   => 'devops',
      mode    => '0600',
      source  => '/vagrant/www/files/dot/devops_ssh/gitlab_known_hosts',
      require => File['/home/devops/.ssh/id_ed25519'],
    }
  }


}
