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
class rabbitmq::params (
  $user            = $title,
  $password        = undef,
  # https://www.rabbitmq.com/management.html#permissions
  # from lowest to highest level - eg. management, policymaker, monitoring, administrator
  $user_tag        = 'administrator',
  # vhostpath - The name of the virtual host to which to grant the user access, defaulting to /.
  $vhost_path      = '/',
  # conf - A regular expression matching resource names for which the user is granted configure permissions.
  # write - A regular expression matching resource names for which the user is granted write permissions.
  # read - A regular expression matching resource names for which the user is granted read permissions.
  # {conf} {write} {read}
  $permission      = '".*" ".*" ".*"',
) {


}
