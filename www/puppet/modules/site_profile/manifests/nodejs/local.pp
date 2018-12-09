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
class site_profile::nodejs::local (

) {


  class { 'nodejs':
    # non-devops servers should use default version or not install nodejs: version => 'default',
    # see https://github.com/nodesource/distributions
    version            => '10.x',
    install_angular    => true,
    install_frontail   => true,
    install_karma      => true,
    install_protractor => true,
    install_tslint     => true,

    # install_cleancss => true,
    # install_gulp     => true,
    # install_less     => "2.7.2",
    # install_uglifyjs => true,
  }


}
