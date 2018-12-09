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
class phpcache::config (
  # opcache
  $max_accelerated_files   = undef,
  $memory_consumption      = undef,
  $interned_strings_buffer = undef,
  $fast_shutdown           = undef,
  $prod_mode               = undef,

  # memcached
  $port                    = undef,
  $memory                  = undef,
) {

  # comment out validate_timestamps in dev environment and set validate_timestamps=0 in prod
  if $prod_mode == true {
    # prod mode so validate_timestamps = 0
    $validate_timestamps = 'opcache.validate_timestamps=0'
  } else {
    # dev mode so comment out validate_timestamps
    $validate_timestamps = '#opcache.validate_timestamps=0'
  }


  # add a notify to the file resource
  file { '/etc/memcached.conf':
    path    => "/etc/memcached.conf",
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    require => Package['memcached'],
    content => template('phpcache/memcached.conf.erb'),
  }


  file { '/etc/php/7.2/mods-available/opcache.ini':
    path    => "/etc/php/7.2/mods-available/opcache.ini",
    ensure  => present,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    require => Package['php'],
    content => template('phpcache/opcache.ini.erb'),
  }


}
