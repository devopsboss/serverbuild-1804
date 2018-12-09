# == Class: ssh
#
# Full description of class ssh here.
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
# include ssh
# ssh::config{ 'ssh_config': }
#
# === Authors
#
# Matthew Hansen
#
class ssh (
  # default: "", eg. "AllowUsers ubuntu" or "AllowUsers devops vagrant"
  $allow_users              = $::ssh::params::allow_users,
  $client_alive_interval    = $::ssh::params::client_alive_interval,
  $client_alive_count_max   = $::ssh::params::client_alive_count_max,
  $kex_algorithms           = $::ssh::params::kex_algorithms,
  $ciphers                  = $::ssh::params::ciphers,
  $macs                     = $::ssh::params::macs,
  $authentication_methods   = $::ssh::params::authentication_methods,
  $log_Level                = $::ssh::params::log_Level,
  $subsystem_sftp           = $::ssh::params::subsystem_sftp,
  $permit_root_login        = $::ssh::params::permit_root_login,
  $use_privilege_separation = $::ssh::params::use_privilege_separation,
  $x11_forwarding           = $::ssh::params::x11_forwarding,
  $pubkey_authentication    = $::ssh::params::pubkey_authentication,
  $password_authentication  = $::ssh::params::password_authentication,
  $ignore_rhosts            = $::ssh::params::ignore_rhosts,
  $use_dns                  = $::ssh::params::use_dns,
  $permit_empty_passwords   = $::ssh::params::permit_empty_passwords,
  $max_auth_tries           = $::ssh::params::max_auth_tries,

) inherits ssh::params {

  #
  # * install
  #
  class { 'ssh::install': }

  #
  # * config
  #
  class { 'ssh::config':
    allow_users              => $allow_users,
    client_alive_interval    => $client_alive_interval,
    client_alive_count_max   => $client_alive_count_max,
    kex_algorithms           => $kex_algorithms,
    ciphers                  => $ciphers,
    macs                     => $macs,
    authentication_methods   => $authentication_methods,
    log_Level                => $log_Level,
    subsystem_sftp           => $subsystem_sftp,
    permit_root_login        => $permit_root_login,
    use_privilege_separation => $use_privilege_separation,
    x11_forwarding           => $x11_forwarding,
    pubkey_authentication    => $pubkey_authentication,
    password_authentication  => $password_authentication,
    ignore_rhosts            => $ignore_rhosts,
    use_dns                  => $use_dns,
    permit_empty_passwords   => $permit_empty_passwords,
    max_auth_tries           => $max_auth_tries,
  }

  #
  # * service
  #
  class { 'ssh::service': }


}
