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
class security_waf::modsec_rule::bad_user_agent (

) {

  #
  # * fail2ban configuration
  #
  file { "/etc/fail2ban/filter.d/modsec-bad_user_agent.conf":
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    source  => "puppet:///modules/security_waf/fail2ban/filter.d/modsec-bad_user_agent.conf",
    # wait until the jail.local file is there
    require => File['/etc/fail2ban/jail.local'],
    # restart apache and fail2ban after copying file over
    # notify  => [Service['apache2'], Package['fail2ban']],
  }


  #
  # * modsec configuration
  #
  file { "/usr/share/modsecurity-crs/custom_rules/bad_user_agents.conf":
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    source  => "puppet:///modules/security_waf/modsec/bad_user_agents.conf",
    require => Package['libapache2-mod-security2'],
  }


  #
  # * modsec data
  #
  file { "/usr/share/modsecurity-crs/custom_rules/bad_user_agents.data":
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    source  => "puppet:///modules/security_waf/modsec/bad_user_agents.data",
    require => Package['libapache2-mod-security2'],
  }


}
