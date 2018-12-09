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
define users::config::mysql (
  $user        = $title,
  $db_user     = undef,
  $db_password = undef,
  $db_host     = undef,
) {

  # database connection
  # $db_user = $server::params_module::mysql_user
  # $db_password = $server::params_module::mysql_user_password
  # $db_host = $server::params_module::mysql_host

  #
  # * get home dir
  #
  if $user == 'root' {
    $home_dir = '/root'
  } elsif $user == 'www-data' {
    $home_dir = '/var/www'
  } else {
    $home_dir = "/home/$user"
  }


  # .my.cnf for mysql database password
  file { "$home_dir/.my.cnf":
    ensure  => file,
    owner   => "$user",
    mode    => '0644',
    path    => "$home_dir/.my.cnf",
    content => template('users/.my.cnf.erb'),
  }

  # #
  # # * If mysql is enabled then notify mysql service, else only copy over .my.cnf
  # #
  # if $server::params::include_mysql == true {
  #   # .my.cnf for mysql database password
  #   file { "$home_dir/.my.cnf":
  #     ensure  => file,
  #     owner   => "$user",
  #     mode    => '0644',
  #     path    => "$home_dir/.my.cnf",
  #     content => template('users/.my.cnf.erb'),
  #     notify  => Service['mysql'],
  #     require => Package['mysql-server'],
  #   }
  # } else {
  #   # .my.cnf for mysql database password
  #   file { "$home_dir/.my.cnf":
  #     ensure  => file,
  #     owner   => "$user",
  #     mode    => '0644',
  #     path    => "$home_dir/.my.cnf",
  #     content => template('users/.my.cnf.erb'),
  #   }
  # }

}
