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
class elastic_stack::params (
  #
  # * install packages
  #
  $install_apm_server         = false,
  $install_elasticsearch      = false,
  $install_filebeat           = false,
  $install_kibana             = false,
  $install_logstash           = false,
  $install_metricbeat         = false,

  # default = 192.168.0.1
  $elasticsearch_network_host = '192.168.0.1',
  # default = 9200
  $elasticsearch_http_port    = '9200',

  # default = 5601
  $kibana_server_port         = '5601',
  # default = "localhost", which usually means remote machines will not be able to connect.
  # therefore changing to "0.0.0.0" so we can access from browser
  # $kibana_server_host         = '"0.0.0.0"',
  $kibana_server_host         = '"localhost"',

  # logstash
  $logstash_syslog            = false,

) {

}
