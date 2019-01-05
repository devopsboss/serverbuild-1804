# Class: project
# ===========================
#
# Full description of class project here.
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
#    class { 'project':
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
define project::install::dashboard::param_files (
  # eg. /srv/devops/dashboard-1804
  $full_project_path = $title,
) {


  # copy env param file
  server::tools::copy_file { "$full_project_path/.env":
    group       => 'www-data',
    # /srv/projects/dashboard-1804/.env.localdev
    source_path => "$full_project_path/.env.localdev",
    requirement => Git::Tools::Refresh[$full_project_path],
  }

}
