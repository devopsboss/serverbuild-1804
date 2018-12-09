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
class security::config::grub (
  $enable_audit_on_boot = undef,

) {


  #
  # * GRUB
  #
  file { '/etc/default/grub':
    path    => '/etc/default/grub',
    # -rw-r--r-- root root
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    require => Exec['apt-update'],
    content => template('security/grub.erb'),
  }

  # update grub ensure the config changes kick in
  exec { 'update-grub':
    path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin"],
    command => 'update-grub',
    user    => 'root',
    require => File['/etc/default/grub']
  }

}
