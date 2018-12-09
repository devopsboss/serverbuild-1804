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
class php::config (
  $php_fpm_listen         = undef,
  $log_level              = undef,
  $max_execution_time     = undef,
  $max_input_time         = undef,
  $max_input_vars         = undef,
  $default_socket_timeout = undef,
  $process_idle_timeout   = undef,
  $memory_limit           = undef,
  $display_errors         = undef,
  $display_startup_errors = undef,
  $file_uploads           = undef,
  $upload_max_filesize    = undef,
  $post_max_size          = undef,
  $max_file_uploads       = undef,
  $session_entropy_length = undef,
  $realpath_cache_size    = undef,
  $realpath_cache_ttl     = undef,
  $gc_probability         = undef,
  $gc_divisor             = undef,
  $gc_maxlifetime         = undef,
  $process_manager        = undef,
  $max_children           = undef,
  $start_servers          = undef,
  $min_spare_servers      = undef,
  $max_spare_servers      = undef,
  $max_requests           = undef,
) {

  # copy php7.2-fpm config
  # modifys listen to "listen 127.0.0.1:9000" for php-fpm
  file { '/etc/php/7.2/fpm/pool.d/www.conf':
    ensure  => file,
    path    => '/etc/php/7.2/fpm/pool.d/www.conf',
    content => template('php/www.conf.erb'),
    notify  => Service['php7.2-fpm'],
    require => Package['php7.2-fpm'],
  }

  # PHP-FPM > PHP.INI
  file { '/etc/php/7.2/fpm/php.ini':
    # ensure      => file,
    path    => '/etc/php/7.2/fpm/php.ini',
    content => template('php/php.ini.erb'),
    notify  => Service['php7.2-fpm'],
    require => Package['php7.2-fpm'],
  }

  # PHP FPM CONF
  file { '/etc/php/7.2/fpm/php-fpm.conf':
    # ensure      => file,
    path    => '/etc/php/7.2/fpm/php-fpm.conf',
    content => template('php/php-fpm.conf.erb'),
    notify  => Service['php7.2-fpm'],
    require => Package['php7.2-fpm'],
  }

  # PHP CLI > PHP.INI
  file { '/etc/php/7.2/cli/php.ini':
    # ensure      => file,
    path    => '/etc/php/7.2/cli/php.ini',
    content => template('php/php.ini.erb'),
    notify  => Service['php7.2-fpm'],
    require => Package['php7.2-fpm'],
  }

}
