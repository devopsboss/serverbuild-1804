# = Class: mysql::config
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
#
# === Authors
#
# Matthew Hansen
#
define git::tools::clone (
  # eg.
  $full_project_path = $title,
  # eg. dashboard-1804
  # $repo_name    = undef,
  # eg. /srv/devops
  $project_path = undef,
  # eg. git@github.com:devopsboss/dashboard-1804.git
  $ssh_url      = undef,
  # 30 min timeout
  $timeout      = 1800,
) {

  exec { "git-clone-$full_project_path":
    path    => ['/bin', '/usr/bin'],
    user    => 'devops',
    # eg. /srv/devops
    cwd     => $project_path,
    # eg. git clone git@github.com:devopsboss/dashboard-1804.git
    command => "git clone $ssh_url",
    timeout => $timeout,
    # git clone unless project folder already exists
    # /srv/devops/dashboard-1804
    unless  => "test -d $full_project_path",
    # ensure the git ssh key & git config email/name has been setup
    require => [File['/home/devops/.ssh/known_hosts'], Exec['git-config-email'], Exec['git-config-name']],
  }

}
