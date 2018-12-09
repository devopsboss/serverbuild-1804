#TODO: server::install::cron
#TODO: server::install::logrotate

#TODO: https://stackoverflow.com/questions/17310333/require-puppet-to-place-a-file-before-starting-service

#TODO: www/puppet/modules/server/manifests/install/libreoffice.pp (~/.config)
class { 'site_profile::server::local': }

class { 'site_profile::apache::small': }
# class {'site_profile::apache::medium': }

class { 'site_profile::awscli::base': }
# class {'site_profile::awscli::remote': }

class { 'site_profile::composer::local': }
# class { 'site_profile::composer::remote': }


#TODO: setup elastic stack
# class { 'site_profile::elastic_stack::local': }


#TODO: setup git::tools::user
#TODO: setup git::tools::refresh?
class { 'site_profile::git::base': }

class { 'site_profile::golang::base': }

class { 'site_profile::java::local': }

#TODO: what about mongodb user & password?
# class { 'site_profile::mongodb::client': }
class { 'site_profile::mongodb::server': }

class { 'site_profile::mysql::local': }

class { 'site_profile::nodejs::local': }

class { 'site_profile::php::local': }
# class { 'site_profile::php::small': }
# class { 'site_profile::php::medium': }

class { 'site_profile::python::base': }


class { 'site_profile::rabbitmq::base': }

class { 'site_profile::ruby::base': }

#TODO: setup security & security_waf
class { 'site_profile::security::local': }

class { 'site_profile::ssh::local': }
class { 'site_profile::ssh::devops_ssh_folder': }

#TODO: www/puppet/modules/security/manifests/tools/sudoers_add_user.pp
#TODO: www/puppet/modules/users/manifests/config/mysql.pp
class { 'site_profile::users::base': }


class { 'site_profile::project::develop_devopshome_localdev': }
class { 'site_profile::project::master_devopshome_localdev': }
