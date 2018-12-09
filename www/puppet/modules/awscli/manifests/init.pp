# == Class: aws
#
# Full description of class aws here.
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
# include aws
#
# === Authors
#
# Matthew Hansen
#
class awscli (
  $aws_access_key_id     = $::awscli::params::aws_access_key_id,
  $aws_secret_access_key = $::awscli::params::aws_secret_access_key,
  $chmod_file            = $::awscli::params::chmod_file,
  $chmod_folder          = $::awscli::params::chmod_folder,
  $region                = $::awscli::params::region,
  $users                 = $::awscli::params::users,
) inherits awscli::params {

  #
  # install
  #
  class { 'awscli::install': }

  #
  # * config
  #
  class { 'awscli::config':
    users        => $users,
    chmod_folder => $chmod_folder,
    chmod_file   => $chmod_file,
  }

  #
  # * service
  #
  class { 'awscli::service': }

}
