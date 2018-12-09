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
define mysql::create::database (
  $db_name    = $title,
  $mysql_user = undef,
  $db_host    = undef,
  $charset    = 'utf8',
) {

  $create_database = "CREATE DATABASE `${db_name}` character SET utf8"
  $grant_privileges = "GRANT ALL on *.* to ${mysql_user}@${db_host}; FLUSH PRIVILEGES"
  $use_root_password = " -uroot -p`cat /root/.passwd/db/mysql`"

  exec { "create-database-${db_name}":
    command  => "mysql -e '$create_database; $grant_privileges;' $use_root_password",
    provider => 'shell',
    path     => ['/bin', '/sbin', '/usr/bin' ],
    require  => Exec["create-mysql_user-$mysql_user"],
    unless   => "mysql -e 'SHOW DATABASES LIKE \"${db_name}\"' $use_root_password | grep -q ${db_name}",
  }
}
