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
define awscli::config::credentials (
  $user                  = $title,
  $chmod_file            = undef,
  $chmod_folder          = undef,
  # template params
  $aws_access_key_id     = undef,
  $aws_secret_access_key = undef,
  $region                = undef,
) {

  #
  # * get home dir
  #
  if $user == 'root' {
    $home_dir = '/root'
  } elsif $user == 'www-data' {
    $home_dir = '/var/www'
  } else {
    $home_dir = "/home/$user"
  }

  #
  # * create .aws folder and copy config files
  #
  file { "$home_dir/.aws":
    ensure => directory,
    mode   => $chmod_folder,
    owner  => $user,
    group  => $user,
    require => Users::Install::User[$user]
  }
  file { "$home_dir/.aws/credentials":
    mode    => $chmod_file,
    owner   => $user,
    group   => $user,
    content => template('awscli/credentials.erb'),
    require => File["$home_dir/.aws"],
  }
  file { "$home_dir/.aws/config":
    mode    => $chmod_file,
    owner   => $user,
    group   => $user,
    content => template('awscli/config.erb'),
    require => File["$home_dir/.aws/credentials"],
  }

}
