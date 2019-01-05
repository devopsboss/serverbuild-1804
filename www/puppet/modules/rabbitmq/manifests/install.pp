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
class rabbitmq::install (
  $user            = $title,
  $password        = undef,
  $user_tag        = undef,
  $vhost_path      = undef,
  $permission      = undef,
) {

  package { 'erlang':
    ensure  => present,
    require => Exec['apt-upgrade']

  }

  #
  # * Install rabbitmq package
  #
  package { 'rabbitmq-server':
    ensure  => present,
    require => Package['erlang']
  }

  #
  # * PLUGIN rabbitmq_management
  #
  exec { 'rabbitmq-plugins enable rabbitmq_management':
    # path    => ["/bin", "/usr/sbin"],
    path        => '/usr/bin:/usr/sbin:/bin',
    # environment => "HOME=/home/devops",
    #TODO: unless / onlyif
    require     => Package['rabbitmq-server'],
    notify      => Service['rabbitmq-server'],
  }


  #
  # * CREATE USER
  #
  rabbitmq::create::user { $user:
    password        => $password,
    user_tag        => $user_tag,
    vhost_path      => $vhost_path,
    permission      => $permission,
  }

}
