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
class apache (
  # enable mods
  $mod_alias              = $::apache::params::mod_alias,
  $mod_actions            = $::apache::params::mod_actions,
  $mod_deflate            = $::apache::params::mod_deflate,
  $mod_expires            = $::apache::params::mod_expires,
  $mod_headers            = $::apache::params::mod_headers,
  $mod_rewrite            = $::apache::params::mod_rewrite,
  $mod_proxy              = $::apache::params::mod_proxy,
  # apache.conf
  $timeout                   = $::apache::params::timeout,
  $keep_alive                = $::apache::params::keep_alive,
  $max_keep_alive_requests   = $::apache::params::max_keep_alive_requests,
  $keep_alive_timeout        = $::apache::params::keep_alive_timeout,
  # mpm_event.conf.erb
  $mpm_type                  = $::apache::params::mpm_type,
  $server_limit              = $::apache::params::server_limit,
  $start_servers             = $::apache::params::start_servers,
  $min_spare_threads         = $::apache::params::min_spare_threads,
  $max_spare_threads         = $::apache::params::max_spare_threads,
  $thread_limit              = $::apache::params::thread_limit,
  $threads_per_child         = $::apache::params::threads_per_child,
  $max_request_workers       = $::apache::params::max_request_workers,
  $max_connections_per_child = $::apache::params::max_connections_per_child,

) inherits apache::params {

  #
  # * install apache & mods
  #
  class { 'apache::install':
    mod_alias   => $mod_alias,
    mod_actions => $mod_actions,
    mod_deflate => $mod_deflate,
    mod_expires => $mod_expires,
    mod_headers => $mod_headers,
    mod_rewrite => $mod_rewrite,
    mod_proxy   => $mod_proxy,
  }
  #
  # * config
  #
  class { 'apache::config':
    # apache.conf
    timeout                   => $timeout,
    keep_alive                => $keep_alive,
    max_keep_alive_requests   => $max_keep_alive_requests,
    keep_alive_timeout        => $keep_alive_timeout,
    # mpm_event.conf
    mpm_type                  => $mpm_type,
    server_limit              => $server_limit,
    start_servers             => $start_servers,
    min_spare_threads         => $min_spare_threads,
    max_spare_threads         => $max_spare_threads,
    thread_limit              => $thread_limit,
    threads_per_child         => $threads_per_child,
    max_request_workers       => $max_request_workers,
    max_connections_per_child => $max_connections_per_child,
  }
  #
  # * service
  #
  class { 'apache::service': }

}
