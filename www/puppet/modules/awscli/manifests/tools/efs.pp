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
define awscli::tools::aws_efs (
  # eg. efs_endpoint = fs-9a0ce9a3.efs.ap-southeast-2.amazonaws.com
  $efs_endpoint = $title,
  $efs_folder   = '/var/efs',
  $mount_params = 'nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2',
) {

  # install for AWS Elastic File System
  package { 'nfs-common':
    ensure  => latest,
    require => Exec['apt-upgrade'],
  }

  # Ensure folder exists
  file { "/srv/efs":
    owner   => 'devops',
    group   => 'devops',
    mode    => '0775',
    ensure  => directory,
  }

  #
  # * mount efs
  #
  # TODO: work in progress
  # exec { 'mount-efs':
  #   #unless  => "test -f ?",
  #   # eg. mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2:/ /srv/efs
  #   command => "mount -t nfs4 -o $mount_params $efs_endpoint:/ $efs_folder",
  #   user    => $server::params::default_user,
  #   #creates => "/srv/efs",
  #   timeout => '30',
  #   require => Package['awscli'],
  # }

}
