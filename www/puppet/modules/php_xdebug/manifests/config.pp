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
class php_xdebug::config (
  $default_enable          = undef,
  $remote_autostart        = undef,
  $remote_connect_back     = undef,
  $remote_enable           = undef,
  $remote_handler          = undef,
  $remote_host             = undef,
  $remote_mode             = undef,
  $remote_port             = undef,
  $show_exception_trace    = undef,
  $show_local_vars         = undef,
  $var_display_max_data    = undef,
  $var_display_max_depth   = undef,
  $max_nesting_level       = undef,
  $profiler_enable         = undef,
  $profiler_enable_trigger = undef,
  $profiler_output_name    = undef,
  $profiler_output_dir     = undef,
  $idekey                  = undef,
) {


  file { '/etc/php/7.2/mods-available/xdebug.ini':
    ensure  => present,
    content => template('php_xdebug/xdebug.ini.erb'),
    require => Package['xdebug'],
    notify  => Service['php7.2-fpm']
  }

}
