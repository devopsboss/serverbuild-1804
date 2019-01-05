#
# * SITE ROLE
#
class { 'site_role::local::role_developer':
  # use a generic git user that will be used for git refreshing
  git_user_name  => 'deploy user',
  git_user_email => 'deployer@example.com',
}
