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
class site_profile::project::profile_dashboard (
  $domain              = undef,
  $allow_vagrant_share = undef,
) {

  #
  # * VAGRANT SHARE DASHBOARD
  #
  # eg. www.dashboard-1804.localdev
  if $allow_vagrant_share == true {
    project::init::dashboard { "develop.$domain":
      webroot_path  => '/vagrant/www/projects/dashboard-1804/public',
      vagrant_share => true,
    }
  }

  #
  # * NON VAGRANT SHARE DASHBOARD
  #
  # eg. www.dashboard-1804.localdev
  project::init::dashboard { "www.$domain":
    webroot_path         => '/srv/devops/dashboard-1804/public',
    vagrant_share        => false,
    auto_update_git      => false,
    auto_update_composer => false,
    auto_update_npm      => false,
    auto_update_asset    => false,
  }

  #
  # * DESIGN PATTERNS
  #
  # eg. design-patterns.dashboard-1804.localdev
  apache::tools::vhost { "design-patterns.$domain":
    vhost_webroot  => '/vagrant/www/projects/php-design-patterns',
    vhost_template => 'localdev',
  }

}
