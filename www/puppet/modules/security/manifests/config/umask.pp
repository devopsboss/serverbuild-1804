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
class security::config::umask (

  # see https://docs.oracle.com/cd/E19683-01/817-0365/secfile-62/index.html
  # Level of Security:      Moderate (740)
  # umask Setting:          027
  # Permissions Disallowed: w for group, rwx for others
  # default: 'umask 022' (744)
  $umask = 'umask 027'
) {

  #
  # * /etc/profile
  #
  file { '/etc/profile':
    path    => '/etc/profile',
    # -rw-r--r--
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('security/umask/profile.erb'),
  }

  # * /etc/init.d/ssh
  #
  file { '/etc/init.d/ssh':
    path    => '/etc/init.d/ssh',
    # -rw-r--r--
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('security/umask/ssh.erb'),
  }

  #
  # * /etc/init.d/sysstat
  #
  file { '/etc/init.d/sysstat':
    path    => '/etc/init.d/sysstat',
    # -rw-r--r--
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('security/umask/sysstat.erb'),
  }

}
