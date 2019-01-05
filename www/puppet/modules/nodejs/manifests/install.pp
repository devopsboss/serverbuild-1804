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
class nodejs::install (
  # "default" (for ubuntu) or "10.x" (for nodesource https://github.com/nodesource/distributions)
  $version            = undef,
  $bin_folder         = undef,
  $mode               = undef,
  $owner              = undef,
  $group              = undef,

  $install_angular    = undef,
  $install_frontail   = undef,
  $install_karma      = undef,
  $install_protractor = undef,
  $install_puppeteer  = undef,
  $install_tslint     = undef,

  # these will likely be removed soon
  $install_cleancss   = undef,
  $install_gulp       = undef,
  $install_less       = undef,
  $install_uglifyjs   = undef,
) {


  class { 'nodejs::install::version':
    version => $version,
  }

  #
  # * NPM Packages
  #
  class { 'nodejs::install::npm':
    bin_folder         => $bin_folder,
    mode               => $mode,
    owner              => $owner,
    group              => $group,

    install_angular    => $install_angular,
    install_frontail   => $install_frontail,
    install_karma      => $install_karma,
    install_protractor => $install_protractor,
    install_puppeteer  => $install_puppeteer,

    # these will likely be removed soon
    install_cleancss   => $install_cleancss,
    install_gulp       => $install_gulp,
    install_less       => $install_less,
    install_tslint     => $install_tslint,
    install_uglifyjs   => $install_uglifyjs,
  }


}
