# = Class: ssh::config
#
# Description
#
# === Parameters
#
# Document parameters here.
#
# [*permitRootLogin*]
#   Used to disable root login, eg. sets "PermitRootLogin no" in "/etc/ssh/sshd_config".
#   Server default is "PermitRootLogin prohibit-password".
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
#  class { 'ssh':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Matthew Hansen
#
class ssh::config (
  $allow_users              = undef,
  $client_alive_interval    = undef,
  $client_alive_count_max   = undef,
  $kex_algorithms           = undef,
  $ciphers                  = undef,
  $macs                     = undef,
  $authentication_methods   = undef,
  $log_Level                = undef,
  $subsystem_sftp           = undef,
  $permit_root_login        = undef,
  $use_privilege_separation = undef,
  $x11_forwarding           = undef,
  $pubkey_authentication    = undef,
  $password_authentication  = undef,
  $ignore_rhosts            = undef,
  $use_dns                  = undef,
  $permit_empty_passwords   = undef,
  $max_auth_tries           = undef,
) {



  file { '/etc/ssh/sshd_config':
    path    => "/etc/ssh/sshd_config",
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('ssh/sshd_config.erb'),
    require => Package['openssh-server'],
    # add a notify to the file resource (restarts service after change)
    notify  => Service['sshd'],
  }

}
