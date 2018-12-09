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
class mysql::params (
  #
  # * credentials
  #
  # eg. localhost or rds dns
  $db_host                  = 'localhost',
  # eg. ['devopshome']
  $db_names                 = false,
  # eg. "db_user"
  $mysql_user               = false,
  # mysql password for $mysql_user
  $mysql_password           = undef,
  $root_user                = 'root',
  # mysql password for $root_user
  $root_password            = undef,

  # install_timezone should be true for local and false for remote servers that only access RDS
  $install_timezone         = false,

  #
  # * /etc/mysql/mysql.conf.d/mysqld.cnf
  #
  # default: bind-address = 127.0.0.1
  $bind_address             = '127.0.0.1',
  # default: key_buffer_size = 16M
  $key_buffer_size          = '16M',
  # default: max_allowed_packet = 16M
  $max_allowed_packet       = '64M',
  # default: thread_stack = 192K
  $thread_stack             = '192K',
  # default: thread_cache_size = 8
  $thread_cache_size        = 8,
  # default: query_cache_limit = 1M
  $query_cache_limit        = '2M',
  # default: query_cache_size = 16M
  $query_cache_size         = '64M',
  $innodb_file_per_table    = 'innodb_file_per_table = 1',
  $innodb_buffer_pool_size  = 'innodb_buffer_pool_size = 64M',
  $innodb_log_buffer_size   = 'innodb_log_buffer_size = 8M',
  $innodb_open_files        = 'innodb_open_files = 16000',
  $innodb_log_file_size     = 'innodb_log_file_size = 64M',

  #
  # * /etc/mysql/my.cnf
  #
  # $sql_mode = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION'
  # remove ONLY_FULL_GROUP_BY
  $sql_mode                 =
  'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION'
  ,
  /* see https://dev.mysql.com/doc/refman/5.7/en/fulltext-fine-tuning.html */
  /* default: innodb_ft_min_token_size = 3 (Minimum length of words that are stored in an InnoDB FULLTEXT index)  */
  $innodb_ft_min_token_size = 2,
  $ft_min_word_len          = 2,
) {


}
