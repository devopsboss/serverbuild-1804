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
class server::params (
  # eg. Etc/UTC
  $timezone       = 'Etc/UTC',

  # /etc/hosts
  $hosts = undef,

  # install
  $install_fonts  = false,

  # java
  # eg. true or false
  $install_java   = false,
  # eg. "openjdk-8-jre" or "default-jre"
  $java_package   = undef,

  # eg. false or ['xsltproc']
  $extra_packages = false,

  #
  # * base packages
  #
  $base_packages  = [
    # send http/https requests
    'curl',
    # random password generator
    'pwgen',

    # * Compression
    'bzip2',
    # p7zip to decompress zip files use AES encryption for their password protection
    'p7zip-full',
    'unzip',
    'zip',

    # * Email
    'sendmail',

    # * Logs
    'logrotate',
    'multitail',

    # * Monitoring
    # for I/O monitoring with iostat
    'sysstat',
    # monitors network traffic and bandwidth usage
    'nload',
    # system-monitor process-viewer
    'htop',
    # I/O monitoring
    'iotop',
    'apachetop',

    # * Text editor
    'vim',
    'nano',

    # * Time
    # chrony - time synchronisation
    # https://blog.ubuntu.com/2018/04/09/ubuntu-bionic-using-chrony-to-configure-ntp
    'chrony',
  ],

) {

}
