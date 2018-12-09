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
define server::tools::permissions (
  # eg. /usr/local/bin/*
  $path        = $title,
  # eg. "644" (user r+w, group r+w, other r) or 750 (user r+w+x, group r+x)
  $chmod       = undef,
  # eg. devops
  $user        = undef,
  # eg. devops
  $group       = undef,
  # eg. false for not recursive
  $recursive   = true,
  # eg. Composer::Tools::Install['devopshome']
  $requirement = undef,
) {

  if $recursive == true {
    $r_flag = '-R'
  } else {
    $r_flag = ''
  }

  if $requirement == undef {
    $require_dependency = Exec['apt-upgrade']
  } else {
    $require_dependency = $requirement
  }

  if $chmod != undef {
    # eg. chmod 750 -R /usr/local/bin/*
    exec { "chmod $chmod $r_flag $path":
      path    => ['/bin'],
      require => $require_dependency
    }
  }

  if $user != undef {
    # eg. chown devops -R /usr/local/bin/*
    exec { "chown $user $r_flag $path":
      path    => ['/bin'],
      require => $require_dependency
    }
  }

  if $group != undef {
    # eg. chgrp devops -R /usr/local/bin/*
    exec { "chgrp $group $r_flag $path":
      path    => ['/bin'],
      require => $require_dependency
    }
  }


}
