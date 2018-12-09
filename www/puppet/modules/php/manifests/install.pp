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
class php::install (
  $extra_modules = undef,
  $base_modules  = undef,
) {

  # install php package
  package { 'php':
    require => Exec['apt-upgrade'],
    ensure  => installed,
  }

  # install php-fpm package
  package { 'php7.2-fpm':
    require => Package['php'],
    ensure  => installed,
  }


  if $extra_modules != false {
    package { $extra_modules:
      ensure  => latest,
      require => Package['php'],
      notify  => Service['php7.2-fpm'],
    }
  }


  if $base_modules != false {
    package { $base_modules:
      ensure  => latest,
      require => Package['php'],
      notify  => Service['php7.2-fpm'],
    }
  }


}