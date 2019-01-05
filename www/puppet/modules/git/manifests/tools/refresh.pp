# == Class: git::tools::refresh
#
# Full description of class gits here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'gits':
#    servers  => [ 'pool.ntp.org', 'ntp.tools.company.com' ],
#  }
#
# === Authors
#
# Matthew Hansen
#
define git::tools::refresh (
  $git_folder  = $title,
  $repo_name   = '',
  $branch      = '',
  $requirement = undef,
  $user        = 'devops',
  # true = always git refresh, false = only git refresh if branch changes
  $auto_update = true,
) {

  # if auto update is true then run composer install if the project path exists
  if $auto_update == true {
    # runs every time
    # only if project path DOES exist
    $onlyif = "/usr/bin/test -d $git_folder"
  } else {

    # does NOT run unless the git branch changes
    # eg. test ! \"$(git branch | grep \* | cut -d ' ' -f2)\" = "feat/13579_upgrade_php72"
    $onlyif = "/usr/bin/test ! \"$(/usr/bin/git rev-parse --abbrev-ref HEAD)\" = \"$branch\""
  }


  #
  # * git checkout require
  #
  if $requirement == undef {
    $git_fetch_require = Git::Tools::Clone[$git_folder]
  } else {
    $git_fetch_require = $requirement
  }


  #
  # * get home dir
  #
  $home_dir = '/home/devops'


  #
  # * UPDATE BRANCH
  #
  if !defined(Exec["git-fetch-$git_folder"]) {
    exec { "git-fetch-$git_folder":
      # this will run as root user unless we set the user (eg. devops)
      user        => $user,
      cwd         => $git_folder,
      environment => "HOME=$home_dir",
      command     => "/usr/bin/git fetch",
      # only if the branch has changed or auto_update is true
      onlyif      => $onlyif,
      require     => $git_fetch_require,
    }
  }

  if !defined(Exec["git-add-$git_folder"]) {
    exec { "git-add-$git_folder":
      # this will run as root user unless we set the user (eg. devops)
      user        => 'devops',
      cwd         => $git_folder,
      environment => "HOME=$home_dir",
      command     => "/usr/bin/git add .",
      # only if the branch has changed or auto_update is true
      onlyif      => $onlyif,
      require     => Exec["git-fetch-$git_folder"],
    }
  }

  if !defined(Exec["git-stash-$git_folder"]) {
    exec { "git-stash-$git_folder":
      # this will run as root user unless we set the user (eg. devops)
      user        => 'devops',
      cwd         => $git_folder,
      environment => "HOME=$home_dir",
      command     => "/usr/bin/git stash",
      # only if the branch has changed or auto_update is true
      onlyif      => $onlyif,
      require     => Exec["git-add-$git_folder"],
    }
  }

  if !defined(Exec["git-checkout-$git_folder"]) {
    exec { "git-checkout-$git_folder":
      # this will run as root user unless we set the user (eg. devops)
      user        => 'devops',
      cwd         => $git_folder,
      environment => "HOME=$home_dir",
      command     => "/usr/bin/git checkout $branch",
      # only if the branch has changed or auto_update is true
      onlyif      => $onlyif,
      require     => Exec["git-stash-$git_folder"],
    }
  }

  # only git pull if auto update is enabled
  if !defined(Exec["git-pull-$git_folder"]) and $auto_update == true {
    exec { "git-pull-$git_folder":
      # this will run as root user unless we set the user (eg. devops)
      user        => 'devops',
      cwd         => $git_folder,
      environment => "HOME=$home_dir",
      command     => "/usr/bin/git pull",
      # only run git pull if git checkout has been run
      require     => Exec["git-checkout-$git_folder"],
    }
  }

}
