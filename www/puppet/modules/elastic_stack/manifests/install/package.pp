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
define elastic_stack::install::package (
  $package = $title
) {

  # Install apm-server or elasticseartch etc
  package { $package:
    ensure  => latest,
    require => Exec['elastic-apt-update']
  }



  # Configure APM Server to start automatically during boot
  # Not required because of www/puppet/modules/elastic_stack/manifests/service.pp

  # exec { "$package-on-boot":
  #   path    => '/bin:/usr/bin',
  #   command => "sudo /bin/systemctl daemon-reload && sudo /bin/systemctl enable $package.service",
  #   #TODO: unless
  #   require => Package[$package]
  # }

}
