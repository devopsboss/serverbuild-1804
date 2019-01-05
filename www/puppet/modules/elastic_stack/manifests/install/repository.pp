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
class elastic_stack::install::repository (
) {

  # ref: https://www.elastic.co/guide/en/elasticsearch/reference/current/deb.html
  #TODO: might be required: sudo apt-get install apt-transport-https

  # Import the Elasticsearch PGP Keyedit
  exec { 'elastic-pgp-key':
    path    => '/bin:/usr/bin:/usr/sbin',
    command => 'wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -',
    unless  => "test -f /etc/apt/sources.list.d/elastic-6.x.list",
    user    => 'root',
    # see www/puppet/modules/site_profile/manifests/java/base.pp
    require => Package['openjdk-8-jre']
    # require => Package['aide'],
  }

  # Installing from the APT repositoryedit
  exec { 'elastic-apt-repo':
    path    => '/bin:/usr/bin:/usr/sbin',
    command =>
      'echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list'
    ,
    unless  => "test -f /etc/apt/sources.list.d/elastic-6.x.list",
    user    => 'root',
    require => Exec['elastic-pgp-key'],
  }

  # Update apt to get the elasticsearch package
  exec { 'elastic-apt-update':
    path    => '/bin:/usr/bin',
    command => 'apt update',
    #TODO: unless
    require => Exec['elastic-apt-repo']
  }


}
