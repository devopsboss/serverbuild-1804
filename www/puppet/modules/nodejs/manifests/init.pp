# Class: nodejs
# ===========================
#
# Full description of class nodejs here.
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
#    class { 'nodejs':
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
class nodejs (
  # "default" (for ubuntu) or "10.x" (for nodesource https://github.com/nodesource/distributions)
  $version            = $::nodejs::params::version,
  $bin_folder         = $::nodejs::params::bin_folder,
  $mode               = $::nodejs::params::mode,
  $owner              = $::nodejs::params::owner,
  $group              = $::nodejs::params::group,

  #
  # * npm
  #
  $install_angular    = $::nodejs::params::install_angular,
  $install_frontail   = $::nodejs::params::install_frontail,
  $install_karma      = $::nodejs::params::install_karma,
  $install_protractor = $::nodejs::params::install_protractor,
  $install_puppeteer  = $::nodejs::params::install_puppeteer,
  $install_tslint     = $::nodejs::params::install_tslint,
  # these will likely be removed soon
  $install_cleancss   = $::nodejs::params::install_cleancss,
  $install_gulp       = $::nodejs::params::install_gulp,
  $install_less       = $::nodejs::params::install_less,
  $install_uglifyjs   = $::nodejs::params::install_uglifyjs,

) inherits nodejs::params {

  #
  # * install
  #
  class { 'nodejs::install':
    version            => $version,
    bin_folder         => $bin_folder,
    mode               => $mode,
    owner              => $owner,
    group              => $group,
    install_angular    => $install_angular,
    install_frontail   => $install_frontail,
    install_karma      => $install_karma,
    install_protractor => $install_protractor,
    install_tslint     => $install_tslint,
    install_puppeteer  => $install_puppeteer,

    # these will likely be removed soon
    install_cleancss   => $install_cleancss,
    install_gulp       => $install_gulp,
    install_less       => $install_less,
    install_uglifyjs   => $install_uglifyjs,
  }

  #
  # * config
  #
  class { 'nodejs::config': }

  #
  # * service
  #
  class { 'nodejs::service': }

}
