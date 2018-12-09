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
class ssh::params (
  # default: "", eg. "AllowUsers ubuntu" or "AllowUsers devops vagrant"
  $allow_users              = '',

  # A user can log in to the server via ssh, and you can set an idle timeout interval to avoid unattended ssh session.
  # Open sshd_config and make sure following values are configured:
  # suggested: "ClientAliveInterval 300", default: "#ClientAliveInterval 0"
  $client_alive_interval    = 'ClientAliveInterval 300',
  # suggested: "ClientAliveCountMax 0", default: "#ClientAliveCountMax 3"
  $client_alive_count_max   = 'ClientAliveCountMax 0',


  #
  # * OpenSSH guidelines
  # * https://wiki.mozilla.org/Security/Guidelines/OpenSSH
  #
  # default: ""
  $kex_algorithms           =
  "KexAlgorithms curve25519-sha256@libssh.org,ecdh-sha2-nistp521,ecdh-sha2-nistp384,ecdh-sha2-nistp256,diffie-hellman-group-exchange-sha256"
  ,
  # default: ""
  $ciphers                  =
  "Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr"
  ,
  # default: ""
  $macs                     =
  "MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,umac-128@openssh.com"
  ,
  # Password based logins are disabled - only public key based logins are allowed.
  # default: ""
  $authentication_methods   = 'AuthenticationMethods publickey',
  # LogLevel VERBOSE logs user's key fingerprint on login. Needed to have a clear audit track of which key was using to log in.
  # default: "#LogLevel INFO"
  $log_Level                = 'LogLevel VERBOSE',
  # Log sftp level file access (read/write/etc.) that would not be easily logged otherwise.
  # default: "Subsystem	sftp	/usr/lib/openssh/sftp-server"
  $subsystem_sftp           = 'Subsystem sftp  /usr/lib/ssh/sftp-server -f AUTHPRIV -l INFO',
  # Root login is not allowed for auditing reasons. This is because it's difficult to track which process belongs to which root user:
  # default: "#PermitRootLogin prohibit-password"
  $permit_root_login        = 'PermitRootLogin No',
  # Use kernel sandbox mechanisms where possible in unprivileged processes
  # default: ""
  $use_privilege_separation = 'UsePrivilegeSeparation sandbox',


  #
  # * SSH security settings (suggestions being used)
  # * https://linux-audit.com/audit-and-harden-your-ssh-configuration/
  #
  # The display server on the client might have a higher exposure to be attacked with X11 traffic forwarded
  # suggested: "X11Forwarding no", default: "X11Forwarding yes"
  $x11_forwarding           = 'X11Forwarding no',
  # Instead of using a normal password-based login, a better way is using public key authentication.
  # Keys are considered much safer and less prone to brute-force attacks. Disable PasswordAuthentication to force users using keys.
  # suggested: "PubkeyAuthentication yes", default: "#PubkeyAuthentication yes"
  $pubkey_authentication    = 'PubkeyAuthentication yes',
  # suggested: "PasswordAuthentication no", default: "#PasswordAuthentication yes"
  $password_authentication  = 'PasswordAuthentication no',

  #
  # * SSH security settings (defaults being used)
  # * https://linux-audit.com/audit-and-harden-your-ssh-configuration/
  #
  # While not common anymore, rhosts was a weak method to authenticate systems. It defines a way to trust another system simply by its IP address.
  # By default, the use of rhosts is already disabled. Make sure to check if it really is.
  # suggested: "IgnoreRhosts yes", default: "#IgnoreRhosts yes"
  $ignore_rhosts            = '#IgnoreRhosts yes',
  # By default, the SSH server can check if the client connecting maps back to the same combination of hostname and IP address.
  # Use the option UseDNS to perform this basic check as an additional safeguard.
  # suggested: "UseDNS yes", default: "UseDNS no"
  $use_dns                  = 'UseDNS no',
  # Accounts should be protected and users should be accountable. For this reason, the usage of empty passwords should not be allowed.
  # This can be disabled with the PermitEmptyPasswords option, which is the default.
  # suggested: "PermitEmptyPasswords no", default: "#PermitEmptyPasswords no"
  $permit_empty_passwords   = '#PermitEmptyPasswords no',
  # To protect against brute-force attacks on the password of a user, limit the number of attempts.
  # This can be done with the MaxAuthTries setting.
  # suggested: "MaxAuthTries 3", default: "#MaxAuthTries 6"
  $max_auth_tries           = '#MaxAuthTries 6',

) {

}
