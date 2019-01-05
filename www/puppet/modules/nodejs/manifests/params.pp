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
class nodejs::params (
  # "default" (for ubuntu) or "10.x" (for nodesource https://github.com/nodesource/distributions)
  $version            = '10.x',
  # eg. "/user/local/bin"
  $bin_folder         = '/usr/local/bin',
  # eg. "0644"
  $mode               = '0750',
  # eg. devops
  $owner              = 'devops',
  # eg. devops
  $group              = 'devops',

  #
  # * npm packages
  # * false (don't install) or true (do install) or "2.7.2" (do install this version)
  #
  $install_angular    = false,
  $install_frontail   = false,
  $install_karma      = false,
  $install_protractor = false,
  $install_puppeteer  = false,
  $install_tslint     = false,

  # these will likely be removed soon
  $install_cleancss   = false,
  $install_gulp       = false,
  $install_less       = false,
  $install_uglifyjs   = false,
) {


}
