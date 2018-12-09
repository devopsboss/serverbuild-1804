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
class php::params (
  # default: listen = /run/php/php7.2-fpm.sock
  $php_fpm_listen         = '127.0.0.1:9000',

  #
  # * php-fpm.conf settings
  #
  # Log level - Possible Values: alert, error, warning, notice, debug (Default Value: notice)
  # Changed from notice to warning to reduce the log file bloat (eg. NOTICE: [pool www] child 33532 exited with code 0)
  $log_level              = "warning",

  #
  # * Timeouts
  #
  # default: max_execution_time = 30
  $max_execution_time     = 300,
  # default: max_input_time = 60,
  $max_input_time         = 300,
  # default: max_input_vars = 1000,
  $max_input_vars         = 2000,
  # default: default_socket_timeout = 60 (Default timeout for socket based streams)
  $default_socket_timeout = 300,
  # default: process_idle_timeout = 10s (only used only when pm is set to 'ondemand')
  $process_idle_timeout   = '300s',

  #
  # * PHP info config
  #
  # default: memory_limit = 128M,
  $memory_limit           = '2048M',
  # default: display_errors = Off
  $display_errors         = 'Off',
  # default: display_startup_errors = Off
  $display_startup_errors = 'Off',
  # default: file_uploads = On
  $file_uploads           = 'On',
  # default: upload_max_filesize = 2M
  $upload_max_filesize    = '20M',
  # default: post_max_size = 8M
  $post_max_size          = '20M',
  # default: max_file_uploads = 20
  $max_file_uploads       = 20,
  # default: session_entropy_length = 32
  $session_entropy_length = 64,
  # default: realpath_cache_size = 4096k
  $realpath_cache_size    = '4096k',
  # default: realpath_cache_ttl = 120
  $realpath_cache_ttl     = '600',
  # default: gc_probability = 0
  $gc_probability         = 1,
  # default: gc_divisor = 1000
  $gc_divisor             = 100000,
  # default: gc_maxlifetime = 1440
  $gc_maxlifetime         = 604800,

  #
  # * PHP performance config
  #
  # https://serversforhackers.com/video/php-fpm-process-management
  #
  $process_manager   = 'dynamic',
  # The hard-limit total number of processes allowed
  $max_children      = '250',
  # When apache starts, have this many processes waiting for requests
  $start_servers     = '40',
  # Number spare processes apache will create
  $min_spare_servers = '20',
  # Number spare processes attempted to create
  $max_spare_servers = '40',
  # The number of requests each child process should execute before respawning.
  $max_requests      = '100000',

  #
  # * modules
  #
  # array of extra php modules to install
  $extra_modules     = false,
  # base php modules
  $base_modules      = [
    # Advanced Message Queuing Protocol (AMQP) - used for message queues eg. RabbitMQ
    'php-amqp',
    # ast - used for phan static analysis https://github.com/nikic/php-ast
    'php-ast',
    # bcmath - Arbitrary Precision Mathematics
    'php-bcmath',
    # read and write bzip2 (.bz2) compressed files
    'php-bz2',
    # cli
    'php-cli',
    # intl
    'php-intl',
    # common
    'php-common',
    # curl
    'php-curl',
    # gd
    'php-gd',
    # mailparse
    'php-mailparse',
    # mbstring
    'php-mbstring',
    # mongodb
    'php-mongodb',
    # TODO: no php 7.2 php-mcrypt
    # 'php-mcrypt',
    # mysql
    'php-mysql',
    # xml
    'php-xml',
    # TODO: no php 7.2 php7.0-zip
    # allows ZipArchive
    # 'php7.0-zip',
    # required for medicare adaptor
    'php-soap',
    # required for PECL (to install mailparse)
    # 'php-pear',
    'php-dev',
    # pdo_sqlite
    'php-sqlite3',
    # enable you to operate with the IMAP protocol, as well as the NNTP, POP3 and local mailbox access methods.
    'php-imap',
    # Tidy is a binding for the Tidy HTML clean and repair utility, require by PhpDocx
    'php-tidy',
    # allow for arbitrary-length integers to be worked with using the GNU MP library (required for simplesamlphp: openid/php-openid)
    'php-gmp',
    # codeception/codeception requires facebook/webdriver which requires ext-zip
    'php-zip',
  ],


) {

}
