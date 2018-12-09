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
class security::config::auditd (
  # best practice to set max_log_file_action to "keep_logs".
  $auditd_max_log_file_action = undef,
) {

  #
  # * AUDITD CONFIG
  #
  file { '/etc/audit/auditd.conf':
    path    => '/etc/audit/auditd.conf',
    # 0640 = -rw-r-----
    mode    => '0640',
    owner   => 'root',
    group   => 'root',
    content => template('security/auditd.conf.erb'),
    require => Package['auditd'],
  }

}
