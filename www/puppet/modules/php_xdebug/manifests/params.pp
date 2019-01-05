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
class php_xdebug::params (
  $project                 = $title,
  # disable by default (use browser plugin to enable)
  $default_enable          = 0,
  $remote_autostart        = 0,
  $remote_connect_back     = 1, # default = 0
  $remote_enable           = 1,
  $remote_handler          = 'dbgp',
  $remote_host             = 'localhost', # default = localhost
  $remote_mode             = 'req',
  $remote_port             = 9000,
  $show_exception_trace    = 0,
  $show_local_vars         = 0,
  $var_display_max_data    = 10000,
  $var_display_max_depth   = 20,
  $max_nesting_level       = 250,
  $profiler_enable         = 0, # default = 0
  $profiler_enable_trigger = 1,
  $profiler_output_name    = "cachegrind.out.%t.%p",
  $profiler_output_dir     = '/srv/devops/tmp/profiler_output',
  $idekey                  = 'ide-xdebug'
) {

}
