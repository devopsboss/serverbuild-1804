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
class apache::config (

  #
  # * /etc/apache2/apache2.conf
  #
  $timeout                   = undef,
  $keep_alive                = undef,
  $max_keep_alive_requests   = undef,
  $keep_alive_timeout        = undef,

  #
  # * /etc/apache2/mods-available/mpm_event.conf
  #
  # $mpm_type = "event" or "worker"
  $mpm_type                  = undef,
  $server_limit              = undef,
  $start_servers             = undef,
  $min_spare_threads         = undef,
  $max_spare_threads         = undef,
  $thread_limit              = undef,
  $threads_per_child         = undef,
  $max_request_workers       = undef,
  $max_connections_per_child = undef,

) {

  file { '/etc/apache2/apache2.conf':
    ensure    => file,
    path      => '/etc/apache2/apache2.conf',
    content   => template('apache/apache2.conf.erb'),
    require   => Package["apache2"],
    subscribe => Package["apache2"],
  }

  # eg. "/etc/apache2/mods-available/mpm_event.conf"
  file { "/etc/apache2/mods-available/mpm_$mpm_type.conf":
    ensure    => file,
    path      => "/etc/apache2/mods-available/mpm_$mpm_type.conf",
    # "apache/mpm_event.conf.erb"
    content   => template("apache/mpm_$mpm_type.conf.erb"),
    require   => Package["apache2"],
    subscribe => Package["apache2"],
  }

  # Remove 000-default.conf
  file { '/etc/apache2/sites-enabled/000-default.conf':
    ensure    => absent,
    path      => '/etc/apache2/sites-enabled/000-default.conf',
    require   => Package["apache2"],
    subscribe => Package["apache2"],
  }

}
