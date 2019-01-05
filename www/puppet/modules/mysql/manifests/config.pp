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
class mysql::config (
  $root_user                = undef,
  $root_password            = undef,

  # true/false mysql-server has been installed
  $install_server           = undef,

  # /etc/mysql/my.cnf
  $sql_mode                 = undef,
  $innodb_ft_min_token_size = undef,
  $ft_min_word_len          = undef,

  # /etc/mysql/mysql.conf.d/mysqld.cnf
  $bind_address             = undef,
  $key_buffer_size          = undef,
  $max_allowed_packet       = undef,
  $thread_stack             = undef,
  $thread_cache_size        = undef,
  $query_cache_limit        = undef,
  $query_cache_size         = undef,
  $innodb_file_per_table    = undef,
  $innodb_buffer_pool_size  = undef,
  $innodb_log_buffer_size   = undef,
  $innodb_open_files        = undef,
  $innodb_log_file_size     = undef,
) {

  #
  # * MYSQL SERVER CONFIG
  #
  if $install_server == true {

    # mysql config file
    file { 'mysqld.cnf':
      # ensure     => file,
      mode      => '0644',
      path      => '/etc/mysql/mysql.conf.d/mysqld.cnf',
      content   => template('mysql/mysqld.cnf.erb'),
      require   => Package["mysql-server"],
      subscribe => Package["mysql-server"],
    }

    # mysql config file
    file { 'my.cnf':
      mode      => '0644',
      path      => '/etc/mysql/my.cnf',
      content   => template('mysql/my.cnf.erb'),
      require   => Package["mysql-server"],
      subscribe => Package["mysql-server"],
    }

  }


  # set the root password
  exec { 'root-password':
    command => "/usr/bin/mysqladmin -u $root_user password $root_password",
    require => Package["mysql-client"],
    notify  => Service['mysql']
  }

  # .my.cnf for mysql database password
  file { "/root/.my.cnf":
    ensure  => file,
    owner   => 'root',
    mode    => '0664',
    path    => '/root/.my.cnf',
    content => template('mysql/.my.cnf.erb'),
  }

}