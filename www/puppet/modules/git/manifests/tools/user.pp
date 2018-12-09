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
define git::tools::user (
  $user           = $title,
  $git_user_name  = '',
  $git_user_email = '',
) {

  #
  # * get home dir
  #
  if $user == 'root' {
    $home_dir = '/root'
  } elsif $user == 'www-data' {
    $home_dir = '/var/www'
  } else {
    $home_dir = "$home_dir"
  }

  # check users_git_access isn't already defined (eg. could be the same as users_default_owner)
  # if !defined(Users::Tools::Home[$user]) {
  #   users { $user: }
  # }

  exec { 'git-user-name':
    # this will run as root user unless we set the user (eg. ubuntu)
    user        => $user,
    command     => "/usr/bin/git config --global user.name '$git_user_name'",
    environment => "HOME=$home_dir",
    # require     => File['git-ssh-permissions'],
    require     => [Package['git'], Users::Install::User[$user]],
  }

  exec { 'git-user-email':
    # this will run as root user unless we set the user (eg. ubuntu)
    user        => $user,
    command     => "/usr/bin/git config --global user.email '$git_user_email'",
    environment => "HOME=$home_dir",
    require     => Exec['git-user-name'],
  }

}
