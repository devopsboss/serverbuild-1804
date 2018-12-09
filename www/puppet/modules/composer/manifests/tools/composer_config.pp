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
define composer::tools::composer_config (
  # eg. '"platform.ext-mongo" "1.6.16"'
  $config_command = $title,
  # eg. /srv/devopsboss/devopshome
  $project_path       = undef,
  # eg. Server::Tools::Copy_file["$project_path/$repo_name/.env"]
  $requirement         = undef,

) {

  exec { "composer-config-$config_command":
    path        => ['/bin', '/usr/bin', '/usr/local/bin'],
    user        => 'devops',
    command     => "composer config $config_command",
    # eg. /srv/projects/devopshome
    cwd         => $project_path,
    environment => "HOME=/home/devops",
    require     => $requirement,
  }

}