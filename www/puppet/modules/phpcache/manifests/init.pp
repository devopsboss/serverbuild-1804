# == Class: phpcache
#
# Full description of class phpcache here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#   ::phpcache{ auto_update => true }
#
#
# === Authors
#
# Matthew Hansen
#
class phpcache (
  # opcache
  $max_accelerated_files   = $::phpcache::params::max_accelerated_files,
  $memory_consumption      = $::phpcache::params::memory_consumption,
  $interned_strings_buffer = $::phpcache::params::interned_strings_buffer,
  $fast_shutdown           = $::phpcache::params::fast_shutdown,
  $prod_mode               = $::phpcache::params::prod_mode,

  # memcached
  $port                    = $::phpcache::params::port,
  $memory                  = $::phpcache::params::memory,

) inherits phpcache::params {

  #
  # * phpcache install
  #
  class { 'phpcache::install':
  }

  #
  # * config
  #
  class { 'phpcache::config':
    # opcache
    max_accelerated_files   => $max_accelerated_files,
    memory_consumption      => $memory_consumption,
    interned_strings_buffer => $interned_strings_buffer,
    fast_shutdown           => $fast_shutdown,
    prod_mode               => $prod_mode,

    # memcached
    port                    => $port,
    memory                  => $memory,
  }

  #
  # * service
  #
  class { 'phpcache::service': }

}
