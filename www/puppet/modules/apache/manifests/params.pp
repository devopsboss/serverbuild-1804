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
class apache::params (
  $mod_alias                 = true,
  $mod_actions               = true,
  $mod_deflate               = true,
  $mod_expires               = true,
  $mod_headers               = true,
  $mod_rewrite               = true,
  $mod_proxy                 = true,

  #
  # * Apache performance config
  #
  # https://httpd.apache.org/docs/2.4/mod/mpm_common.html#serverlimit
  # http://www.devside.net/articles/apache-performance-tuning
  # http://oxpedia.org/wiki/index.php?title=Tune_apache2_for_more_concurrent_connections
  # http://docs.escenic.com/ece-server-admin-guide/5.3/why_a_web_server_tuning.html

  #
  # * apache2.conf
  #
  # Timeout 300,
  $timeout                   = 300,
  # KeepAlive On,
  $keep_alive                = 'On',
  # default: MaxKeepAliveRequests 100,
  $max_keep_alive_requests   = 10000,
  # KeepAliveTimeout 5,
  # When using AWS ELB, ensure this value is higher than ELB timeout
  $keep_alive_timeout        = 300,


  #
  # * Apache Mode config
  #
  #  To check if event mode is enabled, use this command: sudo apachectl -V
  # eg. worker or event (event is default for ubuntu 1804)
  $mpm_type                  = 'event',


  #
  # * mpm_event.conf and mpm_worker.conf
  #
  # Declares the maximum number of running apache processes. If you change this value you have to restart the daemon.
  $server_limit              = 250,
  # StartServers 2,
  # The number of processes to start initially when starting the apache daemon.
  $start_servers             = 40,
  # MinSpareThreads 25,
  # This regulates how many threads may stay idle without being killed. Apache regulates this on its own very well with default values.
  $min_spare_threads         = 75,
  # MaxSpareThreads 75,
  # This regulates how many threads may stay idle without being killed. Apache regulates this on its own very well with default values.
  $max_spare_threads         = 250,
  # ThreadLimit 64,
  # ThreadsPerChild can be configured as high as this value during runtime. If you change this value you have to restart the daemon.
  $thread_limit              = 64,
  # ThreadsPerChild 25,
  # How many threads can be created per process. Can be changed during a reload.
  $threads_per_child         = 32,
  # MaxRequestWorkers 150,
  # (aka MaxClients) - This declares how many concurrent connections we provide. Devided by ThreadsPerChild you get the suitable ServerLimit value. May be less than ServerLimit * ThreadsPerChild to reserve some resources that can be engaged during runtime with increasing MaxClients and reloading the configuration.
  $max_request_workers       = 8000,
  # Defines the number of Connections that a process can handle during its lifetime (keep-alives are counted once). After that it will be killed. This can be used to prevent possible apache memory leaks. If set to 0 the lifetime is infinite.
  $max_connections_per_child = 16000,

) {


}
