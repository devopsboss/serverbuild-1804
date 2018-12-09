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
  $git_folder      = $title,
  $repo_name       = '',
  $branch          = '',
  $initial_require = undef,
  $user            = 'devops',
) {


  #
  # * git checkout require
  #
  if $initial_require == undef {
    $git_fetch_require = Git::Tools::Clone[$repo_name]
  } else {
    $git_fetch_require = $initial_require
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
      # this will run as root user unless we set the user (eg. ubuntu)
      user        => $user,
      command     => "/usr/bin/git fetch",
      cwd         => $git_folder,
      environment => "HOME=$home_dir",
      require     => $git_fetch_require,
    }
  }

  if !defined(Exec["git-add-$git_folder"]) {
    exec { "git-add-$git_folder":
      # this will run as root user unless we set the user (eg. ubuntu)
      user        => 'devops',
      command     => "/usr/bin/git add .",
      cwd         => $git_folder,
      environment => "HOME=$home_dir",
      require     => Exec["git-fetch-$git_folder"],
    }
  }

  if !defined(Exec["git-stash-$git_folder"]) {
    exec { "git-stash-$git_folder":
      # this will run as root user unless we set the user (eg. ubuntu)
      user        => 'devops',
      command     => "/usr/bin/git stash",
      cwd         => $git_folder,
      environment => "HOME=$home_dir",
      require     => Exec["git-add-$git_folder"],
    }
  }

  if !defined(Exec["git-checkout-$git_folder"]) {
    exec { "git-checkout-$git_folder":
      # this will run as root user unless we set the user (eg. ubuntu)
      user        => 'devops',
      command     => "/usr/bin/git checkout $branch",
      cwd         => $git_folder,
      environment => "HOME=$home_dir",
      require     => Exec["git-stash-$git_folder"],
    }
  }

  if !defined(Exec["git-pull-$git_folder"]) {
    exec { "git-pull-$git_folder":
      # this will run as root user unless we set the user (eg. ubuntu)
      user        => 'devops',
      command     => "/usr/bin/git pull",
      cwd         => $git_folder,
      environment => "HOME=$home_dir",
      require     => Exec["git-checkout-$git_folder"],
    }
  }

}
