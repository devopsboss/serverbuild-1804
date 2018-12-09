# Class: site_profile
# ===========================
#
# Full description of class site_profile here.
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
#    class { 'site_profile':
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
class site_profile::project::master_devopshome_localdev (
  $vhost_template = 'localdev',
  $domain         = 'master.devopshome.localdev',
  $repo_name      = 'devopshome',
  $ssh_url        = 'git@gitlab.com:devopsboss/devopshome.git',
  $project_path   = "/srv/devopsboss"
) {

  #
  # * CREATE FOLDERS
  #
  if !defined(Server::Tools::Mkdir[$project_path]) {
    server::tools::mkdir { $project_path: }
  }
  $project_folders = [
    "$project_path/ci_projects",
    "$project_path/reports",
    "$project_path/tmp",
  ]
  server::tools::mkdir { $project_folders:
    requirement => Server::Tools::Mkdir[$project_path]
  }


  #
  # * GIT CLONE
  #
  # git clone git@gitlab.com:devopsboss/devopshome.git
  git::tools::clone { $repo_name:
    project_path => $project_path,
    ssh_url      => $ssh_url,
  }


  #
  # * SETUP PROJECT
  #
  # copy env param file
  server::tools::copy_file { "$project_path/$repo_name/.env":
    group       => 'www-data',
    # /srv/projects/devopshome/.env.localdev
    source_path => "$project_path/$repo_name/.env.localdev",
    requirement => Git::Tools::Clone[$repo_name],
  }
  # composer install
  composer::tools::composer_install { "$project_path/$repo_name":
    requirement => Server::Tools::Copy_file["$project_path/$repo_name/.env"]
  }
  # npm install
  nodejs::tools::npm_install { "$project_path/$repo_name":
    requirement => Git::Tools::Clone[$repo_name],
  }
  # npm run build
  nodejs::tools::npm_run_build { "$project_path/$repo_name":
    requirement => Nodejs::Tools::Npm_install["$project_path/$repo_name"],
  }



  #
  # * PERMISSIONS
  #
  server::tools::permissions { '/usr/local/bin':
    user        => 'devops',
    recursive   => false,
    requirement => Composer::Tools::Composer_install["$project_path/$repo_name"]
  }
  # devops executable permissions for  /usr/local/bin/* after composer install eg. phan
  server::tools::permissions { '/usr/local/bin/*':
    user        => 'devops',
    group       => 'devops',
    chmod       => '750',
    requirement => Server::Tools::Permissions['/usr/local/bin']
  }
  # apache requires access to wkhtmltopdf & image
  server::tools::permissions { '/usr/local/bin/wkhtmlto*':
    group       => 'www-data',
    chmod       => '750',
    requirement => Server::Tools::Permissions["/usr/local/bin/*"]
  }
  # devops project permissions - eg. /srv/projects/devopshome
  server::tools::permissions { "$project_path/$repo_name":
    user        => 'devops',
    group       => 'www-data',
    requirement => [
      Nodejs::Tools::Npm_run_build["$project_path/$repo_name"],
      Composer::Tools::Composer_install["$project_path/$repo_name"]
    ]
  }
  # www-data project var (cache etc) permissions - eg. /srv/projects/devopshome/var/*
  server::tools::permissions { "$project_path/$repo_name/var":
    user        => 'www-data',
    group       => 'devops',
    # 770 = user & group r+w+x
    chmod       => '770',
    requirement => Server::Tools::Permissions["$project_path/$repo_name"]
  }


  #
  # * VHOST
  #
  # eg. master.devopshome.localdev
  if !defined(Apache::Tools::Vhost[$domain]) {
    apache::tools::vhost { $domain:
      # /srv/projects/devopshome/public
      vhost_webroot  => "$project_path/$repo_name/public",
      vhost_template => $vhost_template,
    }
  }

}
