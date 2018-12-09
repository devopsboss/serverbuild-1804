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
class security_waf::params (

  # INSTALL

  #
  # * FAIL2BAN
  #
  # scans log files (e.g. /var/log/apache/error_log) and bans IPs that show the malicious sign
  $install_fail2ban                 = false,

  #
  # * APACHE_MODSEC
  # * security::install::apache_modsec
  # * Mod security is a free Web Application Firewall (WAF)
  #
  $install_apache_modsec            = false,

  # CONFIG - modsecurity.conf
  # ModSecurity initially runs in DetectionOnly mode, in which the WAF examines HTTP(S) traffic, but not actually block malicious requests.
  # - "Off" (disable modsecurity)
  # - "DetectionOnly" (only logs, doesn't block)
  # - "On" (will block malicious requests)
  $sec_rule_engine                  = 'Off',

  # Allow ModSecurity to access request bodies (default "On", "Off")
  $sec_request_body_access          = 'On',

  # Maximum request body size we will accept for buffering
  # default = 13107200 (12.5mb) - as large as the largest file you are willing to accept
  # 30mb = 31457280
  $sec_request_body_limit           = '31457280',
  # default = 131072 (128k) - the size of data, with files excluded
  $sec_request_body_no_files_limit  = '131072',
  # default = 131072 (128k) - how much of "request body" data (POSTed data) should be kept in the memory (RAM), anything more will be placed in the hard disk (just like swapping)
  $sec_request_body_in_memory_limit = '131072',


  # CONFIG - modsec rules
  # Include OWASP ModSecurity CRS rules if installed
  $include_owasp_rules              = false,
  # folder for where the activated rule conf are (used in security2.conf)
  $include_custom_rules             = false,
  # block bad user agents with modsecurity & fail2ban
  $rule_bad_agents                  = false,

) {

  if $include_owasp_rules == true {
    $owasp_rules = 'IncludeOptional /usr/share/modsecurity-crs/owasp-crs.load'
  } else {
    $owasp_rules = ''
  }

  if $include_custom_rules == true {
    $custom_rules = 'IncludeOptional "/usr/share/modsecurity-crs/custom_rules/*.conf"'
  } else {
    $custom_rules = ''
  }
}
