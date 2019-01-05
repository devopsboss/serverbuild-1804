# Class: nodejs
# ===========================
#
# Full description of class nodejs here.
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
#    class { 'nodejs':
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
class nodejs::install::npm::puppeteer (
  # eg. false (don't install) or true (do install) or "1.0" (install specific version)
  $install    = undef,
  # eg. /user/local/bin
  $bin_folder = undef,
  # eg. "0750"
  $mode       = undef,
  # eg. devops
  $owner      = undef,
  # eg. devops
  $group      = undef,
) {

  #
  # * puppeteer - Headless Chrome Node API
  # * see https://github.com/GoogleChrome/puppeteer
  # * see https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md
  #
  if ($install != false) {

    #
    # * install latest version of puppeteer
    #
    if ($install == true) {
      $install_command = 'npm install -g -s puppeteer'
    } else {
      # $install is NOT boolean then MUST be version number
      $version = $install
      $install_command = "npm install -g -s puppeteer@$version"
    }
    exec { 'install-puppeteer':
      path    => '/usr/bin',
      # Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
      # see https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md
      # see https://github.com/GoogleChrome/puppeteer/issues/2270#issuecomment-407407984
      command => "npm config set puppeteer_skip_chromium_download true -g && sudo $install_command",
      creates => "$bin_folder/puppeteer",
      user    => 'root',
      require => Exec['npm-config-prefix']
    }
    #
    # * Permissions
    # * /usr/local/bin/puppeteer ubuntu:www-data 750
    #
    file { "$bin_folder/puppeteer":
      owner   => $owner,
      group   => $group,
      mode    => $mode,
      require => Exec['install-puppeteer']
    }


    #
    # * Packages to install dependencies
    # * see https://github.com/GoogleChrome/puppeteer/issues/3443#issuecomment-433096772
    # * see https://stackoverflow.com/questions/52993002/ubuntu-18-04-headless-chrome-node-api-puppeteer-installation-guide
    #
    $packages = [
      'gconf-service',
      'libasound2',
      'libatk1.0-0',
      'libatk-bridge2.0-0',
      'libc6',
      'libcairo2',
      'libcups2',
      'libdbus-1-3',
      'libexpat1',
      # 'libfontconfig1',
      'libgcc1',
      'libgconf-2-4',
      'libgdk-pixbuf2.0-0',
      'libglib2.0-0',
      'libgtk-3-0',
      'libnspr4',
      'libpango-1.0-0',
      'libpangocairo-1.0-0',
      'libstdc++6',
      'libx11-6',
      'libx11-xcb1',
      'libxcb1',
      'libxcomposite1',
      'libxcursor1',
      'libxdamage1',
      'libxext6',
      'libxfixes3',
      'libxi6',
      'libxrandr2',
      # 'libxrender1',
      'libxss1',
      'libxtst6',
      'ca-certificates',
      # 'fonts-liberation',
      'libappindicator1',
      'libnss3',
      'lsb-release',
      'xdg-utils',
      # 'wget',
    ]

    package { $packages:
      ensure  => present,
      require => Exec['install-puppeteer']
    }


    #
    # * Packages that might have been defined elsewhere
    #

    # also required for server::install::fonts
    if !defined(Package['libfontconfig1']) {
      package { 'libfontconfig1': ensure => latest, require => Exec['install-puppeteer'] }
    }
    # also required for server::install::fonts
    if !defined(Package['fonts-liberation']) {
      package { 'fonts-liberation': ensure => latest, require => Exec['install-puppeteer'] }
    }
    # also required for server::install::wkhtmlto
    if !defined(Package['libxrender1']) {
      package { 'libxrender1': ensure => latest, require => Exec['install-puppeteer'] }
    }


  }
}
