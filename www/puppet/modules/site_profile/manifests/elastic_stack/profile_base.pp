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
class site_profile::elastic_stack::profile_base (
  # eg. kibana.dashboard-1804.localdev
  $kibana_domain = undef
) {


  # elastic stack
  class { 'elastic_stack':
    install_apm_server    => true,
    install_elasticsearch => true,
    install_filebeat      => true,
    install_kibana        => true,
    install_logstash      => true,
    logstash_syslog       => true,
    install_metricbeat    => true,
  }


  #
  # * VHOST for kibana domain
  #
  if !defined(Apache::Tools::Vhost[$kibana_domain]) {
    $vhost_webroot = '/var/www/html'
    $access_log = '/var/log/apache2/access.log'
    $error_log = '/var/log/apache2/error.log'
    $vhost_template = 'localdev'
    $proxy_pass = 'ProxyPass / http://127.0.0.1:5601/'
    $proxy_pass_reverse = 'ProxyPassReverse / http://127.0.0.1:5601/'

    apache::tools::vhost { $kibana_domain:
      vhost_webroot      => $vhost_webroot,
      access_log         => $access_log,
      error_log          => $error_log,
      vhost_template     => $vhost_template,
      proxy_pass         => $proxy_pass,
      proxy_pass_reverse => $proxy_pass_reverse,
    }
  }


}
