# == Class: elastic_stack
#
# Full description of class elastic_stack here.
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
#   ::elastic_stack{ auto_update => true }
#
#
# === Authors
#
# Matthew Hansen
#
class elastic_stack (
  #
  # * install packages
  #
  $install_apm_server         = $::elastic_stack::params::install_apm_server,
  $install_elasticsearch      = $::elastic_stack::params::install_elasticsearch,
  $install_filebeat           = $::elastic_stack::params::install_filebeat,
  $install_kibana             = $::elastic_stack::params::install_kibana,
  $install_logstash           = $::elastic_stack::params::install_logstash,
  $install_metricbeat         = $::elastic_stack::params::install_metricbeat,

  # default = 192.168.0.1
  $elasticsearch_network_host = $::elastic_stack::params::elasticsearch_network_host,
  # default = 9200
  $elasticsearch_http_port    = $::elastic_stack::params::elasticsearch_http_port,

  # default =
  $kibana_server_port         = $::elastic_stack::params::kibana_server_port,
  # default = "localhost", which usually means remote machines will not be able to connect.
  # therefore changing to "0.0.0.0" so we can access from browser
  $kibana_server_host         = $::elastic_stack::params::kibana_server_host,

  # logstash
  $logstash_syslog            = $::elastic_stack::params::logstash_syslog,


) inherits elastic_stack::params {

  #
  # * elastic_stack install
  #
  class { 'elastic_stack::install':
    install_apm_server    => $install_apm_server,
    install_elasticsearch => $install_elasticsearch,
    install_filebeat      => $install_filebeat,
    install_kibana        => $install_kibana,
    install_logstash      => $install_logstash,
    install_metricbeat    => $install_metricbeat,
  }

  #
  # * config
  #
  class { 'elastic_stack::config':
    install_apm_server         => $install_apm_server,
    install_filebeat           => $install_filebeat,
    install_metricbeat         => $install_metricbeat,
    # elasticsearch
    install_elasticsearch      => $install_elasticsearch,
    elasticsearch_network_host => $elasticsearch_network_host,
    elasticsearch_http_port    => $elasticsearch_http_port,
    # kibaba
    install_kibana             => $install_kibana,
    kibana_server_port         => $kibana_server_port,
    kibana_server_host         => $kibana_server_host,
    # logstash
    install_logstash           => $install_logstash,
    logstash_syslog            => $logstash_syslog,
  }

  #
  # * service
  #
  class { 'elastic_stack::service':
    install_apm_server    => $install_apm_server,
    install_elasticsearch => $install_elasticsearch,
    install_filebeat      => $install_filebeat,
    install_kibana        => $install_kibana,
    install_logstash      => $install_logstash,
    install_metricbeat    => $install_metricbeat,
  }

}
