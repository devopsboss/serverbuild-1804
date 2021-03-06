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
define security::tools::sudoers_add_rule (
  # eg. 01_www_data_task_scripts
  $sudoers_rule_name = $title,
  # eg. www-data
  $group             = 'www-data',
  # eg.
  $script_name       = undef,
) {


  #
  # * SUDOERS FILE
  # * ref: https://www.atrixnet.com/allow-an-unprivileged-user-to-run-a-certain-command-with-sudo/
  #
  $sudoers_rule = "%$group ALL=(ALL) NOPASSWD: /srv/devops/dashboard-1804/scripts/task/$script_name"

  file { "/etc/sudoers.d/$sudoers_rule_name":
    # mode    => '0644',
    # owner   => 'root',
    # group   => 'root',
    content => template('security/sudoers_d.erb'),
  }
}
