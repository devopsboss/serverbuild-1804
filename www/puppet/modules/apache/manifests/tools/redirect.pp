# Class: git
# ===========================
#
# Full description of class git here.
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
#    class { 'git':
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
define apache::tools::redirect (
  $redirect_from   = $title,
  $redirect_to     = '',
) {

  #
  # * eg. redirect from non-www to www
  #
  if $redirect_to != '' {

    $vhost_file = "000-redirect_from_$redirect_from.conf"

    #
    # * sites available
    #
    if !defined(File["/etc/apache2/sites-available/$vhost_file"]) {
      file { "/etc/apache2/sites-available/$vhost_file":
        ensure    => file,
        path      => "/etc/apache2/sites-available/$vhost_file",
        content   => template("apache/vhost_redirect.conf.erb"),
        require   => Package["apache2"],
        subscribe => Package["apache2"],
      }
    }
    #
    # * sites enabled
    #
    if !defined(File["/etc/apache2/sites-enabled/$vhost_file"]) {
      file { "/etc/apache2/sites-enabled/$vhost_file":
        ensure    => link,
        target      => "/etc/apache2/sites-available/$vhost_file",
        require   => File["/etc/apache2/sites-available/$vhost_file"],
        subscribe => Package["apache2"],
      }
    }

  }
}
