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
class security::config (

  # auditd - writing audit records to the disk.
  $install_auditd             = undef,
  $auditd_max_log_file_action = undef,

  # firewall
  $enable_ufw                 = undef,
  $allowed_ports              = undef,

  # login.defs
  $login_defs_pass_min_days   = undef,

  # grub - enable
  $enable_audit_on_boot       = undef,

  # rkhunter
  $install_rkhunter           = undef,
  $rkhunter_auto_update       = undef,
) {

  # auditd
  if $install_auditd != false {
    class { 'security::config::auditd':
      auditd_max_log_file_action => $auditd_max_log_file_action
    }
  }

  # firewall / iptables
  class { 'security::config::firewall':
    enable_ufw    => $enable_ufw,
    allowed_ports => $allowed_ports,
  }

  # grub - enable audit on boot
  class { 'security::config::grub':
    enable_audit_on_boot => $enable_audit_on_boot
  }

  # login.defs
  class { 'security::config::login_defs':
    login_defs_pass_min_days => $login_defs_pass_min_days
  }

  # rkhunter
  if $install_rkhunter == true {
    class { 'security::config::rkhunter':
      rkhunter_auto_update => $rkhunter_auto_update
    }
  }

}
