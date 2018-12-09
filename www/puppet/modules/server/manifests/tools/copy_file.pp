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
define server::tools::copy_file (
  $file        = $title,
  $source_path = undef,
  # eg. "0644" (user r+w, group r+w, other r)
  $chmod       = '0644',
  # eg. devops
  $owner       = 'devops',
  # eg. devops
  $group       = 'devops',
  # eg. Git::Tools::Clone['devopshome']
  $requirement = undef,
) {

  if $requirement == undef {
    $require_dependency = Exec['apt-upgrade']
  } else {
    $require_dependency = $requirement
  }

  #
  # * ensure file exists
  #
  if !defined(File[$file]) {
    file { $file:
      ensure  => file,
      source  => $source_path,
      owner   => $owner,
      group   => $group,
      mode    => $chmod,
      require => $require_dependency,
    }
  }


}
