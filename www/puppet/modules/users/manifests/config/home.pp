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
define users::config::home (
  $user = $title,
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


  file { "$home_dir/.bash_aliases":
    ensure => file,
    owner  => $user,
    mode   => '0644',
    path   => "$home_dir/.bash_aliases",
    source => 'puppet:///modules/users/home/.bash_aliases',
  }

  file { "$home_dir/.bash_git":
    ensure => file,
    owner  => $user,
    mode   => '0644',
    path   => "$home_dir/.bash_git",
    source => 'puppet:///modules/users/home/.bash_git',
  }

  file { "$home_dir/.bash_profile":
    ensure => file,
    owner  => $user,
    mode   => '0644',
    path   => "$home_dir/.bash_profile",
    source => 'puppet:///modules/users/home/.bash_profile',
  }

  file { "$home_dir/.bashrc":
    ensure => file,
    owner  => $user,
    mode   => '0644',
    path   => "$home_dir/.bashrc",
    source => 'puppet:///modules/users/home/.bashrc',
  }

  file { "$home_dir/.git-completion.bash":
    ensure => file,
    owner  => $user,
    mode   => '0644',
    path   => "$home_dir/.git-completion.bash",
    source => 'puppet:///modules/users/home/.git-completion.bash',
  }

  file { "$home_dir/.git-prompt.sh":
    ensure => file,
    owner  => $user,
    mode   => '0644',
    path   => "$home_dir/.git-prompt.sh",
    source => 'puppet:///modules/users/home/.git-prompt.sh',
  }

  # ScreenRC
  file { ".screenrc for $user":
    ensure => file,
    owner  => $user,
    mode   => '0644',
    path   => "$home_dir/.screenrc",
    source => 'puppet:///modules/users/home/.screenrc',
  }

  # Leaves out rdoc / ri files for Gems
  # see http://stackoverflow.com/questions/1381725/how-to-make-no-ri-no-rdoc-the-default-for-gem-install
  file { ".gemrc for $user":
    ensure => file,
    owner  => $user,
    mode   => '0644',
    path   => "$home_dir/.gemrc",
    source => 'puppet:///modules/users/home/.gemrc',
  }
}
