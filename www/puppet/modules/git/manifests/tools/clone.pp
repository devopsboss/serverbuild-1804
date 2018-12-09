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
  $repo_name    = $title,
  # eg. /srv/devopsboss
  $project_path = undef,
  # eg. git@gitlab.com:devopsboss/devopshome.git
  $ssh_url      = undef,
  $timeout      = 500,
) {

  exec { "git-clone-$repo_name":
    path    => ['/bin', '/usr/bin'],
    user    => 'devops',
    # eg. /srv/devopsboss
    cwd     => $project_path,
    # eg. git clone git@gitlab.com:devopsboss/devopshome.git
    command => "git clone $ssh_url",
    timeout => $timeout,
    # git clone unless project folder already exists
    # /srv/projects/devopshome
    unless  => "test -d $project_path/$repo_name",
    require => File["/home/devops/.ssh/known_hosts"],
  }

}