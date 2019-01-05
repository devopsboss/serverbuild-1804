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
  # # eg. true or false
  $install_openjdk = $::java::params::install_jdk,
  # # eg. "openjdk-8-jdk" or "default-jdk"
  $openjdk_version = $::java::params::jdk_package,
  # maven - builds java project
  $install_maven   = $::java::params::install_maven,

) inherits java::params {

  #
  # * java jdk install
  #
  class { 'java::install':
    install_jdk   => $install_jdk,
    jdk_package   => $jdk_package,
    install_maven => $install_maven,
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
