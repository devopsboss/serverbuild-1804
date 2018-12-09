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
class mysql::install (
  $install_timezone = undef,
  $db_host          = undef,
  $db_names         = undef,
  $mysql_user       = undef,
  $mysql_password   = undef,
) {


  # install mysql-server package
  package { 'mysql-server':
    ensure  => installed,
    require => Exec['apt-upgrade'],
  }

  # install mysql-client package
  package { 'mysql-client':
    ensure  => installed,
    require => Package['mysql-server'],
  }

  # install mysql-common package
  package { 'mysql-common':
    ensure  => installed,
    require => Package['mysql-server'],
  }


  #
  # * create users
  #
  if $mysql_user != false {
    mysql::create::user { $mysql_user:
      mysql_password => $mysql_password,
      db_host        => $db_host,
    }
  }


  #
  # * create databases
  #
  if $db_names != false {
    mysql::create::database { $db_names:
      mysql_user => $mysql_user,
      db_host    => $db_host,
    }
  }


  #
  # * Load the Time Zone Tables
  #
  # see https://dev.mysql.com/doc/refman/5.7/en/mysql-tzinfo-to-sql.html
  if $install_timezone == true {
    exec { "mysql-timezone-${$mysql_user}":
      command  => "mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u $mysql_user -h $db_host mysql -p$mysql_password",
      provider => 'shell',
      path     => ['/bin', '/sbin', '/usr/bin' ],
      require  => Exec["create-mysql_user-${mysql_user}"],
    }
  }

}
