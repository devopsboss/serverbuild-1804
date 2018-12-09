# == Class: php
#
# Full description of class php here.
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
#   ::php{ auto_update => true }
#
#
# === Authors
#
# Matthew Hansen
#
class php (
  # php7.2-fpm.sock
  $php_fpm_listen         = $::php::params::php_fpm_listen,
  # php-fpm.conf
  $log_level              = $::php::params::log_level,
  # timeouts
  $max_execution_time     = $::php::params::max_execution_time,
  $max_input_time         = $::php::params::max_input_time,
  $max_input_vars         = $::php::params::max_input_vars,
  $default_socket_timeout = $::php::params::default_socket_timeout,
  $process_idle_timeout   = $::php::params::process_idle_timeout,
  # php.ini config
  $memory_limit           = $::php::params::memory_limit,
  $display_errors         = $::php::params::display_errors,
  $display_startup_errors = $::php::params::display_startup_errors,
  $file_uploads           = $::php::params::file_uploads,
  $upload_max_filesize    = $::php::params::upload_max_filesize,
  $post_max_size          = $::php::params::post_max_size,
  $max_file_uploads       = $::php::params::max_file_uploads,
  $session_entropy_length = $::php::params::session_entropy_length,
  $realpath_cache_size    = $::php::params::realpath_cache_size,
  $realpath_cache_ttl     = $::php::params::realpath_cache_ttl,
  $gc_probability         = $::php::params::gc_probability,
  $gc_divisor             = $::php::params::gc_divisor,
  $gc_maxlifetime         = $::php::params::gc_maxlifetime,
  # performance config
  $process_manager        = $::php::params::process_manager,
  $max_children           = $::php::params::max_children,
  $start_servers          = $::php::params::start_servers,
  $min_spare_servers      = $::php::params::min_spare_servers,
  $max_spare_servers      = $::php::params::max_spare_servers,
  $max_requests           = $::php::params::max_requests,

  # php modules
  $extra_modules          = $::php::params::extra_modules,
  $base_modules           = $::php::params::base_modules,

) inherits php::params {

  #
  # * php install
  #
  class { 'php::install':
    extra_modules => $extra_modules,
    base_modules  => $base_modules,
  }

  #
  # * config
  #
  class { 'php::config':
    php_fpm_listen         => $php_fpm_listen,
    log_level              => $log_level,
    max_execution_time     => $max_execution_time,
    max_input_time         => $max_input_time,
    max_input_vars         => $max_input_vars,
    default_socket_timeout => $default_socket_timeout,
    process_idle_timeout   => $process_idle_timeout,
    memory_limit           => $memory_limit,
    display_errors         => $display_errors,
    display_startup_errors => $display_startup_errors,
    file_uploads           => $file_uploads,
    upload_max_filesize    => $upload_max_filesize,
    post_max_size          => $post_max_size,
    max_file_uploads       => $max_file_uploads,
    session_entropy_length => $session_entropy_length,
    realpath_cache_size    => $realpath_cache_size,
    realpath_cache_ttl     => $realpath_cache_ttl,
    gc_probability         => $gc_probability,
    gc_divisor             => $gc_divisor,
    gc_maxlifetime         => $gc_divisor,
    process_manager        => $process_manager,
    max_children           => $max_children,
    start_servers          => $start_servers,
    min_spare_servers      => $min_spare_servers,
    max_spare_servers      => $max_spare_servers,
    max_requests           => $max_requests,
  }

  #
  # * service
  #
  class { 'php::service': }

}
