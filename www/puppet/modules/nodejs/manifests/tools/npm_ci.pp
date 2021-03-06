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
define nodejs::tools::npm_ci (
  # eg. /srv/devops/dashboard-1804
  $project_path = $title,
  # eg. Server::Tools::Copy_file["$project_path/$repo_name/.env"]
  $requirement  = undef,
  # true = npm install runs every time, false = only runs once
  $auto_update  = true,
) {

  # if auto update is true then run npm install if the project path exists
  if $auto_update == true {
    # runs every time
    # only if project path DOES exist
    $onlyif = "test -d $project_path"
  } else {
    # only runs once
    # only if node_modules folder DOES exist
    $onlyif = "test ! -d $project_path/node_modules"
  }



  exec { "npm-install-$project_path":
    path    => ['/bin', '/usr/bin', '/usr/local/bin'],
    user    => 'devops',
    # /srv/devops/dashboard-1804
    cwd     => $project_path,
    command => 'npm ci',
    onlyif  => $onlyif,
    require => $requirement,
  }

}