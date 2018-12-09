# == Class: composer
#
# Full description of class composer here.
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
#   ::composer{ auto_update => true }
#
#
# === Authors
#
# Matthew Hansen
#
class composer (
  $auto_update    = $::composer::params::auto_update,
  $install_script = $::composer::params::install_script,
  $bin_folder     = $::composer::params::bin_folder,
  $user           = $::composer::params::user,
  $group          = $::composer::params::group,
  $mode           = $::composer::params::mode,
) inherits composer::params {

  #
  # * composer install
  #
  class { 'composer::install':
    install_script => $install_script,
    bin_folder     => $bin_folder,
    auto_update    => $auto_update,
    user           => $user,
    group          => $group,
    mode           => $mode,
  }

  #
  # * config
  #
  class { 'composer::config': }

  #
  # * service
  #
  class { 'composer::service': }

}
