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
class ruby::install (
  $install_rails = undef,
) {


  #
  # * install ruby-full
  #
  package { 'ruby-full':
    ensure  => present,
    require => Exec['apt-upgrade']
  }

  #
  # * install rails
  #
  if $install_rails == true {
    package { 'rails':
      ensure  => present,
      require => Package['ruby-full']
    }
  }

  #
  # * INSTALL GEM
  #

  # chunky_png
  package { 'chunky_png':
    ensure => present, provider => 'gem', require => Package['rails'],
  }
  # compass
  package { 'compass':
    ensure => present, provider => 'gem', require => Package['rails'],
  }
  # compass-validator
  package { 'compass-validator':
    ensure => present, provider => 'gem', require => Package['rails'],
  }
  # fssm
  package { 'fssm':
    ensure => present, provider => 'gem', require => Package['rails'],
  }
  # sass
  package { 'sass':
    ensure => present, provider => 'gem', require => Package['rails'],
  }
  # sass-globbing
  package { 'sass-globbing':
    ensure => present, provider => 'gem', require => Package['rails'],
  }
  # deep_merge
  package { 'deep_merge':
    ensure => present, provider => 'gem', require => Package['rails'],
  }
  # activesupport
  package { 'activesupport':
    ensure => present, provider => 'gem', require => Package['rails'],
  }
  # vine
  package { 'vine':
    ensure => present, provider => 'gem', require => Package['rails'],
  }


  #
  # * PERMISSIONS
  #

  $bin_folder = '/usr/local/bin'
  file { "$bin_folder/compass":
    mode => '0775', owner => 'devops', group => 'devops', require => Package['compass'],
  }
  file { "$bin_folder/compass-validate":
    mode => '0775', owner => 'devops', group => 'devops', require => Package['compass-validator'],
  }
  file { "$bin_folder/sass":
    mode => '0775', owner => 'devops', group => 'devops', require => [Package['sass'], Package['sass-globbing']],
  }
  file { "$bin_folder/sass-convert":
    mode => '0775', owner => 'devops', group => 'devops', require => [Package['sass'], Package['sass-globbing']],
  }
  file { "$bin_folder/scss":
    mode => '0775', owner => 'devops', group => 'devops', require => [Package['sass'], Package['sass-globbing']],
  }
}
