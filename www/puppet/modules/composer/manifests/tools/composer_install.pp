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
define composer::tools::composer_install (
  # eg. /srv/devopsboss/devopshome
  $project_path       = $title,
  # eg. Server::Tools::Copy_file["$project_path/$repo_name/.env"]
  $requirement         = undef,

) {

  exec { "composer-install-$project_path":
    path        => ['/bin', '/usr/bin', '/usr/local/bin'],
    # user        => 'devops',
    # command     => '/usr/local/bin/composer install --optimize-autoloader',
    # allow composer scripts since composer isn't running as sudo
    command     => '/usr/local/bin/composer install --optimize-autoloader --classmap-authoritative',
    # eg. /srv/projects/devopshome
    cwd         => $project_path,
    environment => "HOME=/home/devops",
    require     => $requirement,
  }

}