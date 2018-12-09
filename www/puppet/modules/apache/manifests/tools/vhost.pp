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
define apache::tools::vhost (
  # eg. www.test.localdev
  $domain         = $title,
  # if this is set then use it as the vhost document_root eg. /var/www/sitename
  $vhost_webroot  = '',
  # eg. access.log
  $access_log     = '/var/log/apache2/access.log',
  # eg. error_log
  $error_log      = '/var/log/apache2/error.log',
  # eg.
  $server_alias = '',


  # might be useful for local server to have directory index
  # $directory_index = 'DirectoryIndex index.html index.php'
  # for security benefit, no DirectoryIndex for remote servers
  $directory_index = '',

  # aws or localdev
  $vhost_template = 'aws',


  $proxy_pass = '',
  $proxy_pass_reverse = '',
) {

  #
  # * Apache access log
  #
  if $access_log != '' {
    # eg. access.log
    $apache_access_log = $access_log
  } else {
    # eg. /var/log/apache/{domain_name}_access.log
    $apache_access_log = "/var/log/apache2/${domain}_access.log"
  }

  #
  # * Error log
  #
  if $error_log != '' {
    # eg. error.log
    $apache_error_log = $error_log
  } else {
    # eg. /var/log/apache/{domain_name}_error.log
    $apache_error_log = "/var/log/apache2/${domain}_error.log"
  }

  #
  # * Sites available
  #
  # create vhost in sites-available
  if !defined(File["/etc/apache2/sites-available/$domain.conf"]) {
    file { "/etc/apache2/sites-available/$domain.conf":
      ensure    => file,
      path      => "/etc/apache2/sites-available/$domain.conf",
      content   => template("apache/vhost_$vhost_template.conf.erb"),
      require   => Package["apache2"],
      subscribe => Package["apache2"],
    }
  }

  #
  # * Sites enabled
  #
  if !defined(File["/etc/apache2/sites-enabled/$domain.conf"]) {
    # symlink apache site to the site-enabled directory
    file { "/etc/apache2/sites-enabled/$domain.conf":
      ensure  => link,
      target  => "/etc/apache2/sites-available/$domain.conf",
      require => File["/etc/apache2/sites-available/$domain.conf"],
      notify  => Service["apache2"],
    }
  }

}
