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
class nodejs::install::npm::cleancss (
  # eg. false (don't install) or true (do install) or "1.0" (install specific version)
  $install    = undef,
  # eg. ?
  $version    = undef,
  # eg. /user/local/bin
  $bin_folder = undef,
  # eg. "0750"
  $mode       = undef,
  # eg. devops
  $owner      = undef,
  # eg. devops
  $group      = undef,
) {


  #
  # * compress css
  # * see https://www.npmjs.com/package/clean-css-cli
  #
  if ($install != false) {

    #
    # * install
    #
    if ($install == true) {
      $install_command = 'npm install -g -s clean-css-cli'
    } else {
      # if $install isn't boolean then it's a version
      $version = $install
      $install_command = "npm install -g -s clean-css-cli@$version"
    }
    exec { 'install-cleancss':
      path    => '/usr/bin',
      command => "sudo $install_command",
      creates => "$bin_folder/cleancss",
      user    => 'root',
      require => Exec['npm-config-prefix']
    }
    #
    # * Permissions
    # * /usr/local/bin/cleancss ubuntu:www-data 750
    #
    file { "$bin_folder/cleancss":
      owner   => $owner,
      group   => $group,
      mode    => $mode,
      require => Exec['install-cleancss']
    }
  }

}
