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
define users::install::user (
  $user       = $title,
  # $groups     = undef,
  $managehome = undef,
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
  # * ensure user is present
  #
  user { $user:
    ensure     => present,
    shell      => '/bin/bash',
    home       => "$home_dir",
    # groups     => $groups,
    managehome => $managehome,
  }

  # ensure "~/.cache" is owned by devops
  server::tools::mkdir { "$home_dir/.cache":
    owner       => 'devops',
    requirement => User[$user]
  }
  # ensure "~/.config" is owned by devops
  server::tools::mkdir { "$home_dir/.config":
    owner       => 'devops',
    requirement => User[$user]
  }
  # ensure "~/.local" is owned by devops
  server::tools::mkdir { "$home_dir/.local":
    owner       => 'devops',
    requirement => User[$user]
  }


}
