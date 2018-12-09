# == Class: ruby
#
# Full description of class ruby here.
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
#   ::ruby{ auto_update => true }
#
#
# === Authors
#
# Matthew Hansen
#
class ruby (
  $install_rails = $::ruby::params::install_rails,
) inherits ruby::params {

  #
  # * ruby install
  #
  class { 'ruby::install':
    install_rails => $install_rails
  }

  #
  # * config
  #
  class { 'ruby::config': }

  #
  # * service
  #
  class { 'ruby::service': }

}
