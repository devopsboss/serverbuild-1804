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
class security_waf::config (
  # CONFIG - modsecurity.conf
  $sec_rule_engine                  = undef,
  $sec_request_body_access          = undef,
  $sec_request_body_limit           = undef,
  $sec_request_body_no_files_limit  = undef,
  $sec_request_body_in_memory_limit = undef,

  # CONFIG - modsec rules
  # Include OWASP ModSecurity CRS rules if installed
  $include_owasp_rules                      = undef,
  # folder for where the activated rule conf are (used in security2.conf)
  $include_custom_rules                     = undef,
  # block bad user agents with modsecurity & fail2ban
  $rule_bad_agents                  = undef,
) {


  #
  # * APACHE SECURITY MODULE CONFIG
  #
  file { '/etc/modsecurity/modsecurity.conf':
    path    => "/etc/modsecurity/modsecurity.conf",
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('security_waf/modsecurity.conf.erb'),
    require => Package['libapache2-mod-security2'],
  }

  #
  # * RULES CONFIG
  #
  if $include_owasp_rules == true {
    $owasp_rules = 'IncludeOptional /usr/share/modsecurity-crs/owasp-crs.load'
  } else {
    $owasp_rules = '#IncludeOptional /usr/share/modsecurity-crs/owasp-crs.load'
  }
  if $include_custom_rules == true {
    $custom_rules = 'IncludeOptional "/usr/share/modsecurity-crs/custom_rules/*.conf"'
  } else {
    $custom_rules = '#IncludeOptional "/usr/share/modsecurity-crs/custom_rules/*.conf"'
  }
  file { '/etc/apache2/mods-available/security2.conf':
    path    => "/etc/apache2/mods-available/security2.conf",
    # mode    => '0644',
    # owner   => 'root',
    # group   => 'root',
    content => template('security_waf/security2.conf.erb'),
    require => Package['libapache2-mod-security2'],
  }

  #
  # * Definitions of modsec rules
  #
  file { "/etc/fail2ban/jail.local":
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    source  => "puppet:///modules/security_waf/fail2ban/jail.local",
    # wait until fail2ban and modsecurity is installed
    require => Package['fail2ban', 'libapache2-mod-security2'],
  }


  #
  # * Custom rules config
  #
  if $rule_bad_agents == true {
    class { 'security_waf::modsec_rule::bad_user_agent': }
  }

}
