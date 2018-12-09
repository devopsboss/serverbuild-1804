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
class mysql (
  # credentials
  $db_host                  = $::mysql::params::db_host,
  $db_names                 = $::mysql::params::db_names,
  $mysql_user               = $::mysql::params::mysql_user,
  $mysql_password           = $::mysql::params::mysql_password,
  $root_user                = $::mysql::params::root_user,
  $root_password            = $::mysql::params::root_password,

  # install
  $install_timezone         = $::mysql::params::install_timezone,

  # /etc/mysql/mysql.conf.d/mysqld.cnf
  $sql_mode                 = $::mysql::params::sql_mode,
  $innodb_ft_min_token_size = $::mysql::params::innodb_ft_min_token_size,
  $ft_min_word_len          = $::mysql::params::ft_min_word_len,

  # /etc/mysql/my.cnf
  $bind_address             = $::mysql::params::bind_address,
  $key_buffer_size          = $::mysql::params::key_buffer_size,
  $max_allowed_packet       = $::mysql::params::max_allowed_packet,
  $thread_stack             = $::mysql::params::thread_stack,
  $thread_cache_size        = $::mysql::params::thread_cache_size,
  $query_cache_limit        = $::mysql::params::query_cache_limit,
  $query_cache_size         = $::mysql::params::query_cache_size,
  $innodb_file_per_table    = $::mysql::params::innodb_file_per_table,
  $innodb_buffer_pool_size  = $::mysql::params::innodb_buffer_pool_size,
  $innodb_log_buffer_size   = $::mysql::params::innodb_log_buffer_size,
  $innodb_open_files        = $::mysql::params::innodb_open_files,
  $innodb_log_file_size     = $::mysql::params::innodb_log_file_size,

) inherits mysql::params {

  #
  # * install
  #
  class { 'mysql::install':
    install_timezone => $install_timezone,
    db_host          => $db_host,
    db_names         => $db_names,
    mysql_user       => $mysql_user,
    mysql_password   => $mysql_password,
  }

  #
  # * config
  #
  class { 'mysql::config':
    root_user                => $root_user,
    root_password            => $root_password,

    bind_address             => $bind_address,
    key_buffer_size          => $key_buffer_size,
    max_allowed_packet       => $max_allowed_packet,
    thread_stack             => $thread_stack,
    thread_cache_size        => $thread_cache_size,
    query_cache_limit        => $query_cache_limit,
    query_cache_size         => $query_cache_size,
    innodb_file_per_table    => $innodb_file_per_table,
    innodb_buffer_pool_size  => $innodb_buffer_pool_size,
    innodb_log_buffer_size   => $innodb_log_buffer_size,
    innodb_open_files        => $innodb_open_files,
    innodb_log_file_size     => $innodb_log_file_size,

    sql_mode                 => $sql_mode,
    innodb_ft_min_token_size => $innodb_ft_min_token_size,
    ft_min_word_len          => $ft_min_word_len,
  }

  #
  # * service
  #
  class { 'mysql::service': }


}
