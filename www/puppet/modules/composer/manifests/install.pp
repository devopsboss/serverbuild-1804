# Class: git
# ===========================
#
# Full description of class git here.
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
#    class { 'git':
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
class composer::install (
  $install_script = undef,
  $bin_folder     = undef,
  $auto_update    = undef,
  $user           = undef,
  $group          = undef,
  $mode           = undef,
) {

  #
  # * composer install
  #
  exec { 'composer-install':
    command     => $install_script,
    creates     => "$bin_folder/composer",
    environment => [ "COMPOSER_HOME=$bin_folder" ],
    # run from /usr/local/bin folder
    cwd         => $bin_folder,
    require     => Package['php7.2-fpm'],
  }


  #
  # * Permissions
  #
  # group access to usr/local/bin folder so composer install can create symlinks
  file { $bin_folder:
    mode    => '0775',
    group   => $group,
  }
  # user & group access to usr/local/bin/composer
  file { "$bin_folder/composer":
    mode    => '0750',
    owner   => $user,
    group   => $group,
    require => Exec['composer-install']
  }


  if $auto_update == true {
    exec { 'composer-update':
      command     => "$bin_folder/composer self-update",
      environment => [ "COMPOSER_HOME=$bin_folder" ],
      require     => Exec['composer-install'],
    }
  }


}
