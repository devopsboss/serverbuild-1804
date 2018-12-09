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
class apache::install (
  $mod_alias   = undef,
  $mod_actions = undef,
  $mod_deflate = undef,
  $mod_expires = undef,
  $mod_headers = undef,
  $mod_rewrite = undef,
  $mod_proxy   = undef,
) {


  # Install apache2 package
  package { 'apache2':
    ensure  => installed,
    require => Exec['apt-upgrade']
  }


  if $mod_deflate == true {
    exec { "a2enmod deflate":
      path    => "/usr/bin:/usr/sbin:/bin",
      alias   => 'enable-mod-deflate',
      creates => '/etc/apache2/mods-enabled/deflate.load',
      notify  => Service['apache2'],
      require => Package['apache2'],
    }
  }

  if $mod_expires == true {
    exec { "a2enmod expires":
      path    => "/usr/bin:/usr/sbin:/bin",
      alias   => 'enable-mod-expires',
      creates => '/etc/apache2/mods-enabled/expires.load',
      notify  => Service['apache2'],
      require => Package['apache2'],
    }
  }

  if $mod_rewrite == true {
    exec { "a2enmod rewrite":
      path    => "/usr/bin:/usr/sbin:/bin",
      alias   => 'enable-mod-rewrite',
      creates => '/etc/apache2/mods-enabled/rewrite.load',
      notify  => Service['apache2'],
      require => Package['apache2'],
    }
  }

  if $mod_headers == true {
    exec { "a2enmod headers":
      path    => "/usr/bin:/usr/sbin:/bin",
      alias   => 'enable-mod-headers',
      creates => '/etc/apache2/mods-enabled/headers.load',
      notify  => Service['apache2'],
      require => Package['apache2'],
    }
  }

  if $mod_alias == true {
    exec { "a2enmod alias":
      path    => "/usr/bin:/usr/sbin:/bin",
      alias   => 'enable-mod-alias',
      creates => '/etc/apache2/mods-enabled/alias.load',
      notify  => Service['apache2'],
      require => Package['apache2'],
    }

  }

  if $mod_actions == true {
    exec { "a2enmod actions":
      path    => "/usr/bin:/usr/sbin:/bin",
      alias   => 'enable-mod-actions',
      creates => '/etc/apache2/mods-enabled/actions.load',
      notify  => Service['apache2'],
      require => Package['apache2'],
    }
  }


  if $mod_proxy == true {
    exec { "a2enmod proxy":
      path    => "/usr/bin:/usr/sbin:/bin",
      alias   => 'enable-mod-proxy',
      creates => '/etc/apache2/mods-enabled/proxy.load',
      notify  => Service['apache2'],
      require => Package['apache2'],
    }

    exec { "a2enmod proxy_http":
      path    => "/usr/bin:/usr/sbin:/bin",
      alias   => 'enable-mod-proxy_http',
      creates => '/etc/apache2/mods-enabled/proxy_http.load',
      notify  => Service['apache2'],
      require => Exec['a2enmod proxy'],
    }

    #
    # * APACHE FAST CGI
    #
    # NOTE: libapache2-mod-fastcgi has been removed because we are using "a2enmod proxy_fcgi"
    # https://wiki.apache.org/httpd/PHP-FPM
    # https://serverfault.com/a/783176
    # https://askubuntu.com/a/1037193

    exec { "a2enmod proxy_fcgi":
      path    => "/usr/bin:/usr/sbin:/bin",
      alias   => 'enable-mod-proxy_fcgi',
      creates => '/etc/apache2/mods-enabled/proxy_fcgi.load',
      notify  => Service['apache2'],
      require => Exec['a2enmod proxy'],
    }
  }

}
