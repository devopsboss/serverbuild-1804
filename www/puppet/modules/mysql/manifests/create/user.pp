# = Class: mysql::user
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
#
# === Authors
#
# Matthew Hansen
#
define mysql::create::user (
  $mysql_user     = $title,
  $mysql_password = '',
  $db_host        = 'localhost',
) {

  $create_user = "CREATE USER ${mysql_user}@${db_host} IDENTIFIED BY \"${mysql_password}\""
  $use_root_password = " -uroot -p`cat /root/.passwd/db/mysql`"

  exec { "create-mysql_user-${mysql_user}":
    command  => "mysql -e '$create_user' $use_root_password",
    provider => 'shell',
    path     => ['/bin', '/sbin', '/usr/bin' ],
    require  => Service["mysql"],
    unless   => "mysql -u${mysql_user} -p${mysql_password} -e ''",
  }

}
