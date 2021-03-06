# == Class: rabbitmq
#
# Full description of class rabbitmq here.
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
# include rabbitmq
#
# === Authors
#
# Matthew Hansen
#
class rabbitmq (
  $user            = $::rabbitmq::params::user,
  $password        = $::rabbitmq::params::password,
  $user_tag        = $::rabbitmq::params::user_tag,
  $vhost_path      = $::rabbitmq::params::vhost_path,
  $permission      = $::rabbitmq::params::permission,
) inherits rabbitmq::params {


  #
  # * install
  #
  class { 'rabbitmq::install':
    user            => $user,
    password        => $password,
    user_tag        => $user_tag,
    vhost_path      => $vhost_path,
    permission      => $permission,
  }


  #
  # * config
  #
  class { 'rabbitmq::config': }


  #
  # * service
  #
  class { 'rabbitmq::service': }


}
