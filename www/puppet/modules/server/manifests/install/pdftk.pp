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
define server::install::pdftk (
  $install_script = '/srv/serverbuild-1804/www/scripts/pdftk_install.sh',
  $bin_folder     = '/usr/bin',
  # $owner          = 'devops',
  $group          = 'www-data',
  # $mode           = '0755',
) {

  #
  # * pdftk install
  #
  exec { 'pdftk-install':
    command => $install_script,
    creates => "$bin_folder/pdftk",
    # environment => [ "pdftk_HOME=$bin_folder" ],
    # run from /usr/local/bin folder
    cwd     => $bin_folder,
    # require => Users::Config[$owner]
  }


  #
  # * Permissions
  #
  # user & group access to usr/local/bin/pdftk
  file { "$bin_folder/pdftk":
    # mode    => '0755',
    # owner   => $owner,
    group   => $group,
    require => Exec['pdftk-install']
  }


}
