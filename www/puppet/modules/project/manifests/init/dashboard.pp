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
define project::init::dashboard (
  # eg. master.dashboard-1804.localdev
  $domain               = $title,
  $vhost_template       = 'localdev',
  $repo_name            = 'dashboard-1804',
  $ssh_url              = 'git@github.com:devopsboss/dashboard-1804.git',
  $branch               = 'release/1.0',

  # eg. true/false
  $vagrant_share        = undef,

  # paths
  $project_path         = '/srv/devops',
  $asset_path           = 'public/build',
  # eg. /srv/devops/dashboard-1804/public
  $webroot_path      = undef,

  # auto updates
  $auto_update_git      = false,
  $auto_update_composer = false,
  $auto_update_npm      = false,
  $auto_update_asset    = false,

) {

  #
  # * VHOST
  #
  # eg. master.dashboard-1804.localdev
  if !defined(Apache::Tools::Vhost[$domain]) {
    apache::tools::vhost { $domain:
      vhost_webroot  => $webroot_path,
      vhost_template => $vhost_template,
    }
  }

  #
  # * If this project is NOT vagrant share then create folders and git refresh etc
  #
  if $vagrant_share == false {
    #
    # * CREATE FOLDERS
    #
    project::install::dashboard::folders { $project_path: }

    #
    # * GIT SETUP
    #
    project::tools::git_setup { "$project_path/$repo_name":
      repo_name       => $repo_name,
      ssh_url         => $ssh_url,
      project_path    => $project_path,
      branch          => $branch,
      auto_update_git => $auto_update_git,
    }

    #
    # * PARAM FILES
    #
    project::install::dashboard::param_files { "$project_path/$repo_name": }

    #
    # * INSTALL DEPENDENCIES
    #
    project::install::dashboard::dependencies { "$project_path/$repo_name":
      auto_update_composer => $auto_update_composer,
      auto_update_npm      => $auto_update_npm,
    }

    #
    # * INSTALL ASSETS
    #
    project::install::dashboard::assets { "$project_path/$repo_name":
      asset_path        => $asset_path,
      auto_update_asset => $auto_update_asset,
    }

    #
    # * PERMISSIONS
    #
    project::install::dashboard::permissions { "$project_path/$repo_name": }

  }
}
