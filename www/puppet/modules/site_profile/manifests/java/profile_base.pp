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
class site_profile::java::profile_base (
  $install_openjdk = true,
  # install java 8 for ELK stack
  # $openjdk_version = 'openjdk-8-jre',
  $openjdk_version = 'openjdk-8-jre',
  # install maven if java project build/compiling is required
  $install_maven   = false,
) {


  class { 'java':
    install_openjdk => $install_openjdk,
    openjdk_version => $openjdk_version,
    install_maven   => $install_maven,
  }


}
