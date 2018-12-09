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
class security::config::pam (

  # used in /etc/pam.d/common-password
  # see https://linux.die.net/man/8/pam_unix
  $pam_remember            = ' remember=24 ',

  # Restrict the use of su to users in the wheel group (only root group can su)
  $pam_root_group_su_only  = 'auth       required   pam_wheel.so',
  $pam_su_without_password = 'auth       sufficient pam_wheel.so trust',
) {

  #
  # * common-password
  #
  file { '/etc/pam.d/common-password':
    path    => '/etc/pam.d/common-password',
    # -rw-r--r--
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('security/pam/common-password.erb'),
  }

  #
  # * su
  #
  file { '/etc/pam.d/su':
    path    => '/etc/pam.d/su',
    # -rw-r--r--
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('security/pam/su.erb'),
  }

}
