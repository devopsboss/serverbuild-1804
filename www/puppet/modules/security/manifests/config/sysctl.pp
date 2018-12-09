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
define security::config::sysctl (
  #
  # * sysctl.conf variables
  #
  # default: #net.ipv4.conf.all.accept_redirects = 0
  $accept_redirects_ipv4    = 'net.ipv4.conf.all.accept_redirects = 0',
  # default: #net.ipv6.conf.all.accept_redirects = 0
  $accept_redirects_ipv6    = 'net.ipv6.conf.all.accept_redirects = 0',
  # default: # net.ipv4.conf.all.secure_redirects = 1
  $secure_redirects_ipv4    = 'net.ipv4.conf.all.secure_redirects = 0',

  # For *_redirects
  # ICMP redirects tell a host about alternate routes and the current setting allows a routing device to update
  # the routing tables of the host, which is normally not needed unless the host is a router
  $default_accept_redirects = 'net.ipv4.conf.default.accept_redirects = 0',
  $default_secure_redirects = 'net.ipv4.conf.default.secure_redirects = 0',
  $all_send_redirects       = 'net.ipv4.conf.all.send_redirects = 0',
  $default_send_redirects   = 'net.ipv4.conf.default.send_redirects = 0',

  # For log_martians
  # The log_martians setting tells a host to log packets with non-routable source addresses to the kernel log
  $all_log_martians         = 'net.ipv4.conf.all.log_martians = 1',
  $default_log_martians     = 'net.ipv4.conf.default.log_martians = 1',
) {


  #
  # * SYSCTL
  # Do not accept ICMP redirects (prevent MITM attacks)
  # Disable secure redirects
  file { '/etc/sysctl.conf':
    path    => "/etc/sysctl.conf",
    # -rw-r--r--
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('security/sysctl.conf.erb'),
  }

}
