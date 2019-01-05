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
define project::install::dashboard::folders (
  $project_path   = $title
) {

  #
  # * CREATE FOLDERS
  #
  if !defined(Server::Tools::Mkdir[$project_path]) {
    server::tools::mkdir { $project_path:
      # since /srv is a root folder, set permission to 755 instead of 750
      # chmod => '755',
    }
  }
  # /srv/devops/dashboard-1804
  # /srv/devops/projects
  # /srv/devops/reports
  # /srv/devops/logs
  $project_folders = [
    "$project_path/projects",
    "$project_path/reports",
    "$project_path/logs",
  ]
  server::tools::mkdir { $project_folders:
    requirement => Server::Tools::Mkdir[$project_path]
  }

  # /srv/devops/tmp
  server::tools::mkdir { "$project_path/tmp":
    requirement => Server::Tools::Mkdir[$project_path]
  }
  # /srv/devops/tmp/profiler_output
  server::tools::mkdir { "$project_path/tmp/profiler_output":
    requirement => Server::Tools::Mkdir[$project_path]
  }



}
