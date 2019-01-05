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
define server::install::wkhtmlto (
  $target_dir       = '/usr/local/bin',
  # eg. 0.12.2.1 or 0.12.4
  $version          = '0.12.4',
  $download_timeout = 300,
  $owner            = 'devops',
  $group            = 'www-data',
  $mode             = '0750',
) {

  $source_url = "http://github.com/opendevops/wkhtmlto/raw/master/${version}"


  #
  # * wkhtmlto dependencies
  #
  $packages = [
    'xvfb',
    # 'libxrender1',
    'gsfonts-x11',
    'xfonts-75dpi',
    'fontconfig',
  ]

  package { $packages:
    ensure  => latest,
    require => Exec['apt-upgrade'],
  }

  # also required for nodejs::install::npm::puppeteer
  if !defined(Package['libxrender1']) {
    package { 'libxrender1': ensure => latest, require => Exec['install-puppeteer'] }
  }



  #
  # * wkhtmltopdf
  #
  $wkhtmltopdf_target = "${target_dir}/wkhtmltopdf"
  exec { 'wkhtmltopdf-download':
    # --silent --show-error --fail
    command => "/usr/bin/curl  --location ${source_url}/wkhtmltopdf --output ${target_dir}/wkhtmltopdf",
    creates => "${target_dir}/wkhtmltopdf",
    # see http://manpages.ubuntu.com/manpages/xenial/man1/test.1plan9.html
    # unless  => "test -f ${target_dir}/wkhtmltopdf",
    require => Package['curl'],
    timeout => $download_timeout
  }

  #
  # * Permissions
  # * /usr/local/bin/wkhtmltopdf ubuntu:www-data 750
  #
  file { "${target_dir}/wkhtmltopdf":
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    require => Exec['wkhtmltopdf-download']
  }

  #
  # * wkhtmltoimage
  #
  $wkhtmltoimage_target = "${target_dir}/wkhtmltoimage"
  exec { 'wkhtmltoimage-download':
    # --silent --show-error --fail
    command => "/usr/bin/curl --location ${source_url}/wkhtmltoimage --output ${target_dir}/wkhtmltoimage",
    creates => "${target_dir}/wkhtmltoimage",
    # see http://manpages.ubuntu.com/manpages/xenial/man1/test.1plan9.html
    # unless  => "test -f ${target_dir}/wkhtmltoimage",
    # onlyif  => "test ! -f ${target_dir}/wkhtmltoimage",
    require => Package['curl'],
    timeout => $download_timeout
  }

  #
  # * Permissions
  # * /usr/local/bin/wkhtmltoimage ubuntu:www-data 750
  #
  file { "${target_dir}/wkhtmltoimage":
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    require => Exec['wkhtmltoimage-download']
  }

}
