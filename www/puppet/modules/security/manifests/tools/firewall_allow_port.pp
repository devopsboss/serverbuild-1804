# = Class: security_old::firewall::iptables
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp securitys as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_securitys must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#
# === Authors
#
# Matthew Hansen
#
define security::tools::firewall_allow_port (
  $port = $title
) {


  exec { "ufw-allow-port-$port":
    path    => '/bin:/usr/bin:/usr/sbin',
    command => "sudo ufw allow $port/tcp",
    user    => 'root',
    unless => "ufw status | grep -E '${port}/tcp +ALLOW +Anywhere'",
    before  => Exec['ufw-enable'],
  }

}
