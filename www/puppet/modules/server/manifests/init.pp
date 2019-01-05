# == Class: server
#
# Full description of class server here.
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
#   ::server{ auto_update => true }
#
#
# === Authors
#
# Matthew Hansen
#
class server (
  $timezone       = $::server::params::timezone,
  $hosts          = $::server::params::hosts,
  $install_java   = $::server::params::install_java,
  $java_package   = $::server::params::java_package,
  $install_fonts  = $::server::params::install_fonts,
  $extra_packages = $::server::params::extra_packages,
  $base_packages  = $::server::params::base_packages,


) inherits server::params {

  #
  # * server install
  #
  class { 'server::install':
    install_java   => $install_java,
    java_package   => $java_package,
    install_fonts  => $install_fonts,
    extra_packages => $extra_packages,
    base_packages  => $base_packages,
  }

  #
  # * config
  #
  class { 'server::config':
    timezone => $timezone,
    hosts    => $hosts,
  }

  #
  # * service
  #
  class { 'server::service':
  }

}
