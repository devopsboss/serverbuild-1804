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
class elastic_stack::config (
  #
  # * install packages
  #
  $install_elastic_repo       = false,
  $install_apm_server         = false,
  $install_elasticsearch      = false,
  $install_filebeat           = false,
  $install_kibana             = false,
  $install_logstash           = false,
  $install_metricbeat         = false,

  # elasticsearch
  $elasticsearch_network_host = undef,
  $elasticsearch_http_port    = undef,

  # kibana
  $kibana_server_port         = undef,
  $kibana_server_host         = undef,

  # logstash
  $logstash_syslog            = undef,
) {


  #
  # * elasticsearch
  #
  if $install_elasticsearch == true {
    file { '/etc/elasticsearch/elasticsearch.yml':
      ensure    => file,
      path      => '/etc/elasticsearch/elasticsearch.yml',
      content   => template('elastic_stack/elasticsearch.yml.erb'),
      require   => Elastic_stack::Install::Package['elasticsearch'],
      subscribe => Service["elasticsearch"],
    }
  }

  #
  # * kibana
  #
  if $install_kibana == true {
    file { '/etc/kibana/kibana.yml':
      ensure    => file,
      path      => '/etc/kibana/kibana.yml',
      content   => template('elastic_stack/kibana.yml.erb'),
      require   => Elastic_stack::Install::Package['kibana'],
      subscribe => Service["kibana"],
    }
  }

  #
  # * logstash
  #
  if $install_elasticsearch == true {

    if $logstash_syslog == true {
      file { '/etc/logstash/conf.d/logstash-syslog.conf':
        ensure    => file,
        path      => '/etc/logstash/conf.d/logstash-syslog.conf',
        content   => template('elastic_stack/logstash/logstash-syslog.conf.erb'),
        require   => Elastic_stack::Install::Package['logstash'],
        subscribe => Service['logstash'],
      }
    }

  }


  #
  # * metricbeat
  #
  if $install_metricbeat == true {
    file { '/etc/metricbeat/metricbeat.yml':
      ensure    => file,
      path      => '/etc/metricbeat/metricbeat.yml',
      content   => template('elastic_stack/metricbeat.yml.erb'),
      require   => Elastic_stack::Install::Package['metricbeat'],
      subscribe => Service['metricbeat'],
    }
  }


}
