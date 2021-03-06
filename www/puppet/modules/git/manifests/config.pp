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
class git::config (
  $user_email = undef,
  $user_name  = undef,
) {


  #
  # * user.email
  #
  exec { 'git-config-email':
    path        => ['/bin', '/usr/bin'],
    user        => 'devops',
    cwd         => '/home/devops',
    environment => "HOME=/home/devops",
    # eg. git config --global user.email "you@example.com"
    command     => "git config --global user.email \"$user_email\"",
    # git config --global user.email
    onlyif      => "test ! \"$(git config --global user.email)\" = \"$user_email\"",
    require     => File["/home/devops/.ssh/known_hosts"],
    # require => Users::Install::User['devops']
  }

  #
  # * user.name
  #
  exec { 'git-config-name':
    path        => ['/bin', '/usr/bin'],
    user        => 'devops',
    cwd         => '/home/devops',
    environment => "HOME=/home/devops",
    # eg. git config --global user.name "John Doe"
    command     => "git config --global user.name \"$user_name\"",
    # git config --global user.name
    onlyif      => "test ! \"$(git config --global user.name)\" = \"$user_name\"",
    require     => File["/home/devops/.ssh/known_hosts"],
    # require => Users::Install::User['devops']
  }

}
