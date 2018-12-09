# == Class: security_waf
#
# Full description of class security_waf here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#   ::security_waf{ auto_update => true }
#
#
# === Authors
#
# Matthew Hansen
#
class security_waf (
  # * FAIL2BAN
  # scans log files (e.g. /var/log/apache/error_log) and bans IPs that show the malicious sign
  # $install_fail2ban                 = $::security_waf::params::install_fail2ban,

  # * APACHE_MODSEC
  # * Mod security is a free Web Application Firewall (WAF)
  # $install_apache_modsec            = $::security_waf::params::install_apache_modsec,

  # CONFIG - modsecurity.conf
  # rule engine to log only ("DetectionOnly") or block requests ("On") or do nothing ("Off")
  $sec_rule_engine                  = $::security_waf::params::sec_rule_engine,
  # Allow ModSecurity to access request bodies (default "On", "Off")
  $sec_request_body_access          = $::security_waf::params::sec_request_body_access,
  # Maximum request body size we will accept for buffering
  $sec_request_body_limit           = $::security_waf::params::sec_request_body_limit,
  # default = 131072 (128k) - the size of data, with files excluded
  $sec_request_body_no_files_limit  = $::security_waf::params::sec_request_body_no_files_limit,
  # default = 131072 (128k) - how much of "request body" data (POSTed data) should be kept in the memory (RAM), anything more will be placed in the hard disk (just like swapping)
  $sec_request_body_in_memory_limit = $::security_waf::params::sec_request_body_in_memory_limit,

  # CONFIG - modsec rules
  # Include OWASP ModSecurity CRS rules if installed
  $include_owasp_rules              = $::security_waf::params::include_owasp_rules,
  # folder for where the activated rule conf are (used in security2.conf)
  $include_custom_rules             = $::security_waf::params::include_custom_rules,
  # block bad user agents with modsecurity & fail2ban
  $rule_bad_agents                  = $::security_waf::params::rule_bad_agents,

) inherits security_waf::params {

  #
  # * install
  #
  class { 'security_waf::install': }

  #
  # * config
  #
  class { 'security_waf::config':
    # CONFIG - modsecurity.conf
    sec_rule_engine                  => $sec_rule_engine,
    sec_request_body_access          => $sec_request_body_access,
    sec_request_body_limit           => $sec_request_body_limit,
    sec_request_body_no_files_limit  => $sec_request_body_no_files_limit,
    sec_request_body_in_memory_limit => $sec_request_body_in_memory_limit,
    # CONFIG - MODSEC RULES
    include_owasp_rules                      => $include_owasp_rules,
    include_custom_rules                     => $include_custom_rules,
    # block bad user agents with modsecurity & fail2ban
    rule_bad_agents                  => $rule_bad_agents,
  }

  #
  # * service
  #
  class { 'security_waf::service':

  }

}
