# == Class: java
#
# Full description of class java here.
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
#   ::java{ auto_update => true }
#
#
# === Authors
#
# Matthew Hansen
#
class java (
  # eg. false or "openjdk-8-jre"
  $openjdk_version = $::java::params::install_openjdk,
  # maven - builds java project
  $install_maven   = $::java::params::install_maven,
) inherits java::params {

  #
  # * java install
  #
  class { 'java::install':
    openjdk_version => $openjdk_version,
    install_maven   => $install_maven,
  }

  #
  # * config
  #
  class { 'java::config': }

  #
  # * service
  #
  class { 'java::service': }

}
