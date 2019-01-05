# = Class: rabbitmq::user
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
define rabbitmq::create::user (
  $username        = $title,
  $password        = undef,
  $user_tag        = undef,
  $vhost_path      = undef,
  $permission      = undef,
) {

  #
  # * ADD USER
  #
  exec { "rabbitmqctl_add_user_${username}":
    command   => "/usr/sbin/rabbitmqctl add_user ${username} ${password}",
    unless    => "/usr/sbin/rabbitmqctl list_users | grep -i ${username}",
    notify    => Exec["rabbitmqctl_set_permissions_${username}"],
    require   => Service['rabbitmq-server'],
  }

  #
  # * SET PERMISSIONS
  #
  exec { "rabbitmqctl_set_permissions_${username}":
    command     => "/usr/sbin/rabbitmqctl set_permissions -p ${vhost_path} ${username} ${permission}",
    refreshonly => true,
    require     => Exec["rabbitmqctl_add_user_${username}"],
  }

  #
  # * SET USER TAGS
  #
  exec { "rabbitmqctl_set_user_tags_${username}":
    command   => "/usr/sbin/rabbitmqctl set_user_tags ${username} ${user_tag}",
    require   => Exec["rabbitmqctl_set_permissions_${username}"],
  }

}
