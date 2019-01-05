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
class site_profile::rabbitmq::profile_base (
  $rabbitmq_domain = 'rabbitmq.dashboard-1804.localdev',
) {


  #
  # * install rabbitmq with user config
  #
  class { 'rabbitmq':
    user     => 'mq_user',
    password => 'strongpassword',
  }

  #
  # * VHOST for rabbitmq domain
  #
  if !defined(Apache::Tools::Vhost[$rabbitmq_domain]) {
    $vhost_webroot = '/var/www/html'
    $access_log = '/var/log/apache2/access.log'
    $error_log = '/var/log/apache2/error.log'
    $vhost_template = 'localdev'

    # see https://www.rabbitmq.com/management.html#proxy
    $proxy_pass = '
  AllowEncodedSlashes On
  ProxyPass /api http://127.0.0.1:15672/api nocanon
  ProxyPass /    http://127.0.0.1:15672/'
    $proxy_pass_reverse = 'ProxyPassReverse / http://127.0.0.1:15672/'

    apache::tools::vhost { $rabbitmq_domain:
      vhost_webroot      => $vhost_webroot,
      access_log         => $access_log,
      error_log          => $error_log,
      vhost_template     => $vhost_template,
      proxy_pass         => $proxy_pass,
      proxy_pass_reverse => $proxy_pass_reverse,
    }
  }


}
