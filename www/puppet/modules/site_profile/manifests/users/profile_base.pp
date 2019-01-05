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
class site_profile::users::profile_base (

) {

  class { 'users':
    # users  => ['devops', 'root', 'vagrant', 'www-data'],
    users  => ['devops', 'root', 'www-data'],
    groups => ['devops']
  }
  # user devops
  users::config { 'devops': config_home => true }
  users::tools::usermod { "devops:devops": user => 'devops', group => 'devops' }
  users::tools::usermod { "devops:www-data": user => 'devops', group => 'www-data' }
  # user www-data
  users::config { 'www-data': config_home => false }
  users::tools::usermod { "www-data:devops": user => 'www-data', group => 'devops' }
  # user vagrant
  # users::config { 'vagrant': config_mysql => false }


}
