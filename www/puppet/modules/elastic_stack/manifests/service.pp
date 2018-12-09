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
class elastic_stack::service (
  #
  # * install packages
  #
  $install_apm_server    = undef,
  $install_elasticsearch = undef,
  $install_filebeat      = undef,
  $install_kibana        = undef,
  $install_logstash      = undef,
  $install_metricbeat    = undef,
){


  # ensure apm-server service is running
  if $install_apm_server == true {
    service { 'apm-server':
      ensure    => running,
      enable  => true,
      require => Elastic_stack::Install::Package['apm-server'],
    }
  }

  # ensure elasticsearch service is running
  if $install_elasticsearch == true {
    service { 'elasticsearch':
    ensure    => running,
      enable  => true,
      require => Elastic_stack::Install::Package['elasticsearch'],
    }
  }

  # ensure filebeat service is running
  if $install_filebeat == true {
    service { 'filebeat':
      ensure    => running,
      enable  => true,
      require => Elastic_stack::Install::Package['filebeat'],
    }
  }

  # ensure kibana service is running
  if $install_kibana == true {
    service { 'kibana':
      ensure  => running,
      enable  => true,
      require => Elastic_stack::Install::Package['kibana'],
    }
  }

  # ensure logstash service is running
  if $install_logstash == true {
    service { 'logstash':
      ensure  => running,
      enable  => true,
      require => Elastic_stack::Install::Package['logstash'],
    }
  }

  # ensure metricbeat service is running
  if $install_metricbeat == true {
    service { 'metricbeat':
      ensure  => running,
      enable  => true,
      require => Elastic_stack::Install::Package['metricbeat'],
    }
  }


}
