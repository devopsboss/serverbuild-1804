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
class security::install (
  # aide - intrusion detection
  $install_aide                = undef,
  $aide_db_path                = undef,

  # auditd - writing audit records to the disk
  $install_auditd              = undef,

  # chkrootkit - check for signs of a rootkit
  $install_chkrootkit          = undef,

  # clamav - antivirus engine for detecting trojans, viruses, malware & other malicious threats
  $install_clamav              = undef,

  # lynis - run security scans and provides guidance during system hardening
  $install_lynis               = undef,

  # openssl - secure requests
  $install_openssl             = undef,

  # rkhunter - scans for rootkits, backdoors and possible local exploits
  $install_rkhunter            = undef,

  # firewall
  # $install_ufw = undef,

) {

  # aide - intrusion detection
  if $install_aide != false {
    class { 'security::install::aide': aide_db_path => $aide_db_path }
  }

  # auditd - writing audit records to the disk
  if $install_auditd != false {
    class { 'security::install::auditd': }
  }

  # chkrootkit - check for signs of a rootkit
  if $install_chkrootkit != false {
    class { 'security::install::chkrootkit': }
  }

  # clamav - antivirus engine for detecting trojans, viruses, malware & other malicious threats
  if $install_clamav != false {
    class { 'security::install::clamav': }
  }

  # lynis - run security scans and provides guidance during system hardening
  if $install_lynis != false {
    class { 'security::install::lynis': }
  }

  # openssl - secure requests
  if $install_openssl != false {
    class { 'security::install::openssl': }
  }

  # rkhunter - scans for rootkits, backdoors and possible local exploits
  if $install_rkhunter != false {
    class { 'security::install::rkhunter': }
  }

}
