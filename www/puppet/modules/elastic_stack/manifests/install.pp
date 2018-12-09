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
class elastic_stack::install (
  #
  # * install packages
  #
  $install_apm_server    = undef,
  $install_elasticsearch = undef,
  $install_filebeat      = undef,
  $install_kibana        = undef,
  $install_logstash      = undef,
  $install_metricbeat    = undef,
) {


  # if one of the packages are enabled to install then ensure the elastic repo is setup
  if $install_apm_server == true
    or $install_elasticsearch == true
    or $install_filebeat == true
    or $install_logstash == true
    or $install_metricbeat == true {
    $install_elastic_repo = true
  } else {
    # no elastic packages are going to be installed so do NOT install the elastic repository
    $install_elastic_repo = false
  }

  # add elastic repo so we can apt install elasticsearch etc
  if $install_elastic_repo == true {
    class { 'elastic_stack::install::repository': }
  }

  # apm-server
  if $install_apm_server == true {
    elastic_stack::install::package { 'apm-server': }
  }

  # elasticsearch
  if $install_elasticsearch == true {
    elastic_stack::install::package { 'elasticsearch': }
  }

  # filebeat
  if $install_filebeat == true {
    elastic_stack::install::package { 'filebeat': }
  }

  # kibana
  if $install_kibana == true {
    elastic_stack::install::package { 'kibana': }
  }

  # logstash
  if $install_logstash == true {
    elastic_stack::install::package { 'logstash': }
  }

  # metricbeat
  if $install_metricbeat == true {
    elastic_stack::install::package { 'metricbeat': }
  }

}
