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
define users::config::ssh (
  $user               = $title,
  $private_key_source = "puppet:///modules/ssh/$user",
  $private_key_name   = "id_rsa",
  $public_key_source  = "puppet:///modules/ssh/$user",
  $public_key_name    = "id_rsa.pub",
) {

  #
  # * get home dir
  #
  if $user == 'root' {
    $home_dir = '/root'
  } elsif $user == 'www-data' {
    $home_dir = '/var/www'
  } else {
    $home_dir = "/home/$user"
  }

  # Ensure project_path exists
  file { "$home_dir/.ssh":
    owner   => $user,
    group   => $user,
    mode    => '0600',
    ensure  => directory,
    recurse => true,
  }


  # copy private key
  file { "$user/$private_key_name":
    ensure  => file,
    owner   => $user,
    group   => $user,
    mode    => '0600',
    path    => "$home_dir/.ssh/$private_key_name",
    source  => "puppet:///modules/ssh/$user/$private_key_name",
    require => File["$home_dir/.ssh"],
  }

  # copy public key
  file { "$user/$public_key_name":
    ensure  => file,
    owner   => $user,
    group   => $user,
    mode    => '0600',
    path    => "$home_dir/.ssh/$public_key_name",
    source  => "puppet:///modules/ssh/$user/$public_key_name",
    require => File["$home_dir/.ssh"],
  }


  # add public key to authorized_keys
  exec { "$user/authorized_keys":
    command => "cat $home_dir/.ssh/$public_key_name >> $home_dir/.ssh/authorized_keys",
    require => File["$user/$public_key_name"],
    notify  => Service["sshd"]
  }

  # authorized_keys > create unique file
  exec { "$user/authorized_keys-unique-file":
    command => "sort -u $home_dir/.ssh/authorized_keys > $home_dir/.ssh/authorized_keys_unique",
    require => Exec["$user/authorized_keys"],
  }

  # authorized_keys > use unique file
  exec { "$user/authorized_keys-use-unique":
    command => "mv $home_dir/.ssh/authorized_keys_unique $home_dir/.ssh/authorized_keys",
    require => Exec["$user/authorized_keys-unique-file"],
    notify  => Service["sshd"]
  }

  file { "$home_dir/.ssh/authorized_keys":
    ensure  => file,
    owner   => $user,
    group   => $user,
    mode    => '0600',
    require => Exec["$user/authorized_keys-use-unique"],
  }

}
