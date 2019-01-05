# Class: site_role
# ===========================
#
# Full description of class site_role here.
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
#    class { 'site_role':
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
class site_role::local::role_developer (
  # use a generic git user that will be used for git refreshing
  $git_user_name  = 'deploy user',
  $git_user_email = 'deployer@example.com'
) {


  #TODO: server::install::cron
  #TODO: server::install::logrotate


  #
  # * SERVER - timezone, fonts, base packages, java jre, wkhtmlto, libreoffice
  #
  #TODO: www/puppet/modules/server/manifests/install/libreoffice.pp (~/.config)
  class { 'site_profile::server::profile_local': }

  #
  # * APACHE
  #
  class { 'site_profile::apache::profile_small': }
  # class {'site_profile::apache::medium': }

  #
  # * AWSCLI
  #
  class { 'site_profile::awscli::profile_base': }
  # class {'site_profile::awscli::remote': }

  #
  # * COMPOSER
  #
  class { 'site_profile::composer::profile_local': }
  # class { 'site_profile::composer::remote': }

  #
  # * ELASTIC STACK
  #
  #TODO: setup elastic stack config
  class { 'site_profile::elastic_stack::profile_local': }

  #
  # * GIT
  #
  class { 'site_profile::git::profile_base': user_name => $git_user_name, user_email => $git_user_email }

  #
  # * GOLANG
  #
  # class { 'site_profile::golang::profile_base': }

  #
  # * JAVA - openjdk (jre installed in server module), maven
  #
  # class { 'site_profile::java::profile_base': }

  #
  # * MONGO DB
  #
  #TODO: what about mongodb user & password?
  # class { 'site_profile::mongodb::profile_client': }
  class { 'site_profile::mongodb::profile_server': }

  #
  # * MYSQL
  #
  class { 'site_profile::mysql::profile_local': }

  #
  # * NODEJS
  #
  class { 'site_profile::nodejs::profile_local': }

  #
  # * PHP
  #
  class { 'site_profile::php::profile_local': }
  # class { 'site_profile::php::profile_small': }
  # class { 'site_profile::php::profile_medium': }

  #
  # * PYTHON
  #
  # class { 'site_profile::python::profile_base': }

  #
  # * RABBITMQ
  #
  class { 'site_profile::rabbitmq::profile_base': }

  #
  # * RUBY - rails
  #
  class { 'site_profile::ruby::profile_base': }

  #
  # * SECURITY
  #
  #TODO: setup security & security_waf
  class { 'site_profile::security::profile_local': }

  #
  # * SSH
  #
  class { 'site_profile::ssh::profile_local': }

  #
  # * USERS
  #
  class { 'site_profile::users::profile_base': }

  #
  # * PROJECTS
  #
  class { 'site_profile::project::profile_dashboard':
    domain              => 'dashboard-1804.localdev',
    allow_vagrant_share => true,
  }

}
