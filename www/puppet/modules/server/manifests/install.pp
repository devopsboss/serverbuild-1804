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
class server::install (
  $install_java   = undef,
  $java_package   = undef,
  $install_fonts  = undef,
  $extra_packages = undef,
  $base_packages  = undef,
) {


  # #
  # # * Default paths
  # #
  # Exec {
  #   path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
  # }


  #
  # * Then run apt update
  #
  exec { 'apt-update':
    path    => '/bin:/usr/bin',
    command => 'apt update',
    require => Exec["restart cron service"]
  }

  #
  # * Install java
  #
  if $install_java == true {
    package { $java_package:
      ensure  => latest,
      require => Exec['apt-update']
    }
    # apt upgrade after installing java to ensure the correct package is installed
    $upgrade_require = Package[$java_package]
  } else {
    # apt upgrade without java requires apt-update
    $upgrade_require = Exec['apt-update']
  }

  #
  # * # apt upgrade
  #
  exec { 'apt-upgrade':
    path        => '/bin:/usr/bin',
    environment => 'DEBIAN_FRONTEND=noninteractive',
    # command     => 'apt-get -y -o DPkg::options::="--force-confdef" -o DPkg::options::="--force-confold" upgrade',
    command     => 'apt-get -y upgrade',
    # require     => [Exec['apt-update'], Security::Config['security_config']]
    require     => Exec['apt-update']
  }


  if $base_packages != false {
    package { $base_packages:
      ensure  => latest,
      require => Exec['apt-upgrade'],
    }
  }

  if $extra_packages != false {
    package { $extra_packages:
      ensure  => latest,
      require => Exec['apt-upgrade'],
    }
  }

  if $install_fonts != false {
    class { 'server::install::fonts': }
  }

}
