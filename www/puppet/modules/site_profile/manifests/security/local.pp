# Class: site_profile
# ===========================
#
# Full description of class site_profile here.
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
#    class { 'site_profile':
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
class site_profile::security::local (
  # 80   = http
  # 443  = https
  # 22   = ssh
  # 53   = dns
  # 3306 = allow RDS access (not allowed by default)
  # 4444 = allow protractor access (not allowed by default)
  # 9200 = elasticsearch port (not allowed by default)
  # 5601 = Kibana (not allowed by default)
  # ? = logstash (not allowed by default)
  # ? = filebeat (not allowed by default)
  # ? = metricbeat (not allowed by default)
  # ? = apm (not allowed by default)
  # 8080 = tomcat default port (eg. health provider identifier api client using springboot)
  # 15672 = rabbitmq
  $allowed_ports = ['80', '443', '22', '53', '3306', '4444', '9200','5061','15672']
) {


  class { 'security':
    # don't install aide locally (too slow within vagrant share)
    install_aide       => false,
    install_auditd     => true,
    install_chkrootkit => true,
    install_clamav     => true,
    install_lynis      => true,
    install_openssl    => true,
    install_rkhunter   => true,
    enable_ufw         => true,
    allowed_ports      => $allowed_ports
  }


  class { 'security_waf':
    sec_rule_engine      => 'DetectionOnly',
    include_owasp_rules  => false,
    include_custom_rules => true,
    rule_bad_agents      => true,
  }


}
