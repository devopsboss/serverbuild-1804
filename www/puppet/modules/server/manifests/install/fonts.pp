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
class server::install::fonts (

) {


  $packages = [
    # required for phantomjs
    'libfontconfig1',
    # recommended for pdf generation
    'fonts-liberation',
    # windows fonts for pdf generation
    'ttf-mscorefonts-installer',
    'msttcorefonts',
  ]

  package { $packages:
    ensure  => latest,
    require => Exec['apt-upgrade'],
  }

  # accept license for microsoft font support (eg. Times New Roman)
  exec { 'accept-msttcorefonts-license':
    path    => '/bin:/usr/bin',
    command =>
      '/bin/sh -c "echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections"'
    ,
    unless  => 'debconf-get-selections | egrep "msttcorefonts/accepted-mscorefonts-eula.*true"'
  }



}
