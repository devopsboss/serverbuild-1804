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
class security (

  # aide - intrusion detection
  $install_aide               = $::security::params::install_aide,
  $aide_db_path               = $::security::params::aide_db_path,

  # auditd - writing audit records to the disk
  $install_auditd             = $::security::params::install_auditd,
  $auditd_max_log_file_action = $::security::params::auditd_max_log_file_action,

  # chkrootkit - check for signs of a rootkit
  $install_chkrootkit         = $::security::params::install_chkrootkit,

  # clamav - antivirus engine for detecting trojans, viruses, malware & other malicious threats
  $install_clamav             = $::security::params::install_clamav,

  # firewall
  $enable_ufw                 = $::security::params::enable_ufw,
  $allowed_ports              = $::security::params::allowed_ports,

  # grub - enable audit
  $enable_audit_on_boot       = $::security::params::enable_audit_on_boot,

  # /etc/login.defs - Minimum number of days allowed between password changes
  $login_defs_pass_min_days   = $::security::params::login_defs_pass_min_days,

  # lynis - run security scans and provides guidance during system hardening
  $install_lynis              = $::security::params::install_lynis,

  # openssl - secure requests
  $install_openssl            = $::security::params::install_openssl,

  # pam - user authentication
  $pam_remember               = $::security::params::pam_remember,
  $pam_root_group_su_only     = $::security::params::pam_root_group_su_only,
  $pam_su_without_password    = $::security::params::pam_su_without_password,

  # rkhunter - scans for rootkits, backdoors and possible local exploits
  $install_rkhunter           = $::security::params::install_rkhunter,
  $rkhunter_auto_update       = $::security::params::rkhunter_auto_update,

  # /etc/sysctl.conf - networking config
  $accept_redirects_ipv4      = $::security::params::accept_redirects_ipv4,
  $accept_redirects_ipv6      = $::security::params::accept_redirects_ipv6,
  $secure_redirects_ipv4      = $::security::params::secure_redirects_ipv4,
  $default_accept_redirects   = $::security::params::default_accept_redirects,
  $default_secure_redirects   = $::security::params::default_secure_redirects,
  $all_send_redirects         = $::security::params::all_send_redirects,
  $default_send_redirects     = $::security::params::default_send_redirects,
  $all_log_martians           = $::security::params::all_log_martians,
  $default_log_martians       = $::security::params::default_log_martians,

  # umask - system default permissions for newly created files/folders
  $umask                      = $::security::params::default_log_martians,

) inherits security::params {

  #
  # * security install
  #
  class { 'security::install':
    install_aide       => $install_aide,
    aide_db_path       => $aide_db_path,
    install_auditd     => $install_auditd,
    install_chkrootkit => $install_chkrootkit,
    install_clamav     => $install_clamav,
    install_lynis      => $install_lynis,
    install_openssl    => $install_openssl,
    install_rkhunter   => $install_rkhunter,
  }

  #
  # * config
  #
  class { 'security::config':
    # auditd
    install_auditd             => $install_auditd,
    auditd_max_log_file_action => $auditd_max_log_file_action,

    # firewall
    enable_ufw                 => $enable_ufw,
    allowed_ports              => $allowed_ports,

    # grub
    enable_audit_on_boot       => $enable_audit_on_boot,

    install_rkhunter           => $install_rkhunter,
    rkhunter_auto_update       => $rkhunter_auto_update,
  }

  #
  # * service
  #
  class { 'security::service': }

}
