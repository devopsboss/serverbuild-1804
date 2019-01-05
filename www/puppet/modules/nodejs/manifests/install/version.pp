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
class nodejs::install::version (
  # "default" (for ubuntu) or "10.x" (for nodesource https://github.com/nodesource/distributions)
  $version  = undef,
) {


  if $version == '10.x' {
    #
    # * nodejs PPA
    #
    exec { "nodejs-setup-$version":
      path    => '/bin:/usr/bin',
      command => "curl -sL https://deb.nodesource.com/setup_$version | sudo -E bash -",
      # run this unless /usr/bin/nodejs DOES exist
      #unless => "test -f /usr/bin/nodejs",
      # only run this if /usr/bin/nodejs does NOT exist
      onlyif  => "test ! -f /usr/bin/nodejs",
      require => Exec['apt-upgrade'],
    }

    # Install nodejs package
    package { 'nodejs':
      ensure  => latest,
      require => Exec["nodejs-setup-$version"],
    }


  } else {

    #
    # * Install ubuntu default version, eg. v8.10.0 is default for ubuntu 1804
    #

    # Install nodejs package
    package { 'nodejs':
      ensure  => latest,
      require => Exec['apt-upgrade'],
    }

    # Ensure /usr/local/bin/node is also avaliable
    # http://stackoverflow.com/a/24592328
    exec { 'nodejs-update-alternatives':
      path    => '/bin:/usr/bin',
      command => 'update-alternatives --install /usr/bin/node nodejs /usr/bin/nodejs 100',
      # only run this if /usr/bin/nodejs does NOT exist
      onlyif  => "test ! -f /usr/bin/node",
      require => Package['nodejs']
    }

    # Install npm
    package { 'npm':
      ensure  => latest,
      require => Package['nodejs'],
    }

  }
}
