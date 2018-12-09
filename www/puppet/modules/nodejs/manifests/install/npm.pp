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
class nodejs::install::npm (
  $bin_folder         = undef,
  $mode               = undef,
  $owner              = undef,
  $group              = undef,

  #
  # * npm packages
  # * false (don't install) or true (do install) or "2.7.2" (do install this version)
  #
  $install_angular    = undef,
  $install_frontail   = undef,
  $install_karma      = undef,
  $install_protractor = undef,
  $install_tslint     = undef,

  # these will likely be removed soon
  $install_cleancss   = undef,
  $install_gulp       = undef,
  $install_less       = undef,
  $install_uglifyjs   = undef,
) {

  #TODO: create object or array that contains [bin_folder, mode, owner, and group] and then pass through to packages?


  #
  # * NPM Packages
  #
  class { 'nodejs::install::npm::angular':
    install => $install_angular, bin_folder => $bin_folder, mode => $mode, owner => $owner, group => $group
  }
  class { 'nodejs::install::npm::karma':
    install => $install_karma, bin_folder => $bin_folder, mode => $mode, owner => $owner, group => $group
  }
  class { 'nodejs::install::npm::protractor':
    install => $install_protractor, bin_folder => $bin_folder, mode => $mode, owner => $owner, group => $group
  }
  class { 'nodejs::install::npm::frontail':
    install => $install_frontail, bin_folder => $bin_folder, mode => $mode, owner => $owner, group => $group
  }

  # these will likely be removed soon
  class { 'nodejs::install::npm::cleancss':
    install => $install_cleancss, bin_folder => $bin_folder, mode => $mode, owner => $owner, group => $group
  }
  class { 'nodejs::install::npm::gulp':
    install => $install_gulp, bin_folder => $bin_folder, mode => $mode, owner => $owner, group => $group
  }
  class { 'nodejs::install::npm::less':
    install => $install_less, bin_folder => $bin_folder, mode => $mode, owner => $owner, group => $group
  }
  class { 'nodejs::install::npm::tslint':
    install => $install_tslint, bin_folder => $bin_folder, mode => $mode, owner => $owner, group => $group
  }
  class { 'nodejs::install::npm::uglifyjs':
    install => $install_uglifyjs, bin_folder => $bin_folder, mode => $mode, owner => $owner, group => $group
  }

}
