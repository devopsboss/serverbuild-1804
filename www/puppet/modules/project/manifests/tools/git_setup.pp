# Class: project
# ===========================
#
# Full description of class project here.
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
#    class { 'project':
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
define project::tools::git_setup (
  # eg. /srv/devops/dashboard-1804
  $full_project_path = $title,
  # eg. dashboard-1804
  $repo_name         = undef,
  # eg. git@github.com:devopsboss/dashboard-1804.git
  $ssh_url           = undef,
  # eg. /srv/devops
  $project_path      = undef,
  # eg. master
  $branch            = undef,
  # eg. true/false - true will always run git add/stash/checkout/pull, false only runs if the branch is different
  $auto_update_git   = undef,
) {



  #
  # * GIT CLONE
  #
  git::tools::clone { $full_project_path:
    project_path => $project_path,
    ssh_url      => $ssh_url,
  }


  #
  # * GIT REFRESH
  #
  git::tools::refresh { $full_project_path:
    repo_name   => $repo_name,
    branch      => $branch,
    auto_update => $auto_update_git
  }

}
