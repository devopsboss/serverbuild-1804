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
class security::params (

  #
  # * AIDE intrusion detection
  # * security::install::aide
  #
  $install_aide                 = false,
  $aide_db_path                 = '/var/lib/aide/aide.db',

  #
  # * AUDITD - writing audit records to the disk
  #
  $install_auditd               = false,
  # default: ROTATE
  # best practice to set max_log_file_action to "keep_logs".
  $auditd_max_log_file_action   = 'keep_logs',

  #
  # * CHKROOTKIT - Linux rootkit scanner (http://www.chkrootkit.org/)
  #
  $install_chkrootkit           = false,

  #
  # * CLAMAV - antivirus engine for detecting trojans, viruses, malware & other malicious threats
  #
  $install_clamav               = false,

  #
  # * FIREWALL
  #
  $enable_ufw                  = true,
  # array of ports
  # 80 =   allow HTTP inbound and replies
  # 443 =  allow HTTPS inbound and replies
  # 22 =   allow ssh inbound and replies
  # 53 =   allow DNS searches
  $allowed_ports                = ['80', '443', '22', '53'],

  #
  # * grub - ensure that auditing will occur during boot before auditd is started
  #
  # default: "", suggested: "audit=1"
  $enable_audit_on_boot         = 'audit=1',

  #
  # * LOGIN_DEFS - eg. Minimum number of days allowed between password changes
  #
  #	default: 0
  $login_defs_pass_min_days     = 7,

  #
  # * LYNIS - security auditing tool (https://cisofy.com/lynis/)
  #
  # sudo lynis audit system --quiet --no-colors
  $install_lynis                = false,

  #
  # * OPENSSL - secure requests
  #
  # secure requests
  $install_openssl              = false,

  #
  # * PAM - user authentication
  #
  # used in /etc/pam.d/common-password
  # see https://linux.die.net/man/8/pam_unix
  $pam_remember                 = ' remember=24 ',
  # Restrict the use of su to users in the wheel group (only root group can su)
  $pam_root_group_su_only       = 'auth       required   pam_wheel.so',
  $pam_su_without_password      = 'auth       sufficient pam_wheel.so trust',

  #
  # * RKHUNTER - scans for rootkits, backdoors and possible local exploits
  #
  # rkhunter - https://help.ubuntu.com/community/RKhunter
  # sudo rkhunter --checkall
  $install_rkhunter             = false,
  # set this to yes to enable automatic database updates (default: false)
  $rkhunter_auto_update         = 'yes',

  #TODO: this is not being used
  # * SUDOERS - give user(s) sudo access
  # * security::tools::sudoers_add_user
  #
  # array of users or false
  # $sudo_users                   = ['www-data'],
  $sudo_users                   = false,

  #
  # * SYSCTL - networking config /etc/sysctl.conf
  # * security::config::sysctl
  #
  # default: #net.ipv4.conf.all.accept_redirects = 0
  $accept_redirects_ipv4        = 'net.ipv4.conf.all.accept_redirects = 0',
  # default: #net.ipv6.conf.all.accept_redirects = 0
  $accept_redirects_ipv6        = 'net.ipv6.conf.all.accept_redirects = 0',
  # default: # net.ipv4.conf.all.secure_redirects = 1
  $secure_redirects_ipv4        = 'net.ipv4.conf.all.secure_redirects = 0',
  # For *_redirects
  # ICMP redirects tell a host about alternate routes and the current setting allows a routing device to update
  # the routing tables of the host, which is normally not needed unless the host is a router
  $default_accept_redirects     = 'net.ipv4.conf.default.accept_redirects = 0',
  $default_secure_redirects     = 'net.ipv4.conf.default.secure_redirects = 0',
  $all_send_redirects           = 'net.ipv4.conf.all.send_redirects = 0',
  $default_send_redirects       = 'net.ipv4.conf.default.send_redirects = 0',
  # For log_martians
  # The log_martians setting tells a host to log packets with non-routable source addresses to the kernel log
  $all_log_martians             = 'net.ipv4.conf.all.log_martians = 1',
  $default_log_martians         = 'net.ipv4.conf.default.log_martians = 1',

  #
  # * UMASK - system default permissions for newly created files/folders
  #
  # Permissions Disallowed: w for group, rwx for others
  # default is umask 022 (744) and changed to umask 027 (740)
  $umask                        = 'umask 027',

) {

}
