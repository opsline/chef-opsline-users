default['opsline-users']['users_databag_name'] = 'users'
default['opsline-users']['groups_databag_name'] = 'groups'

case node['platform_family']
when 'mac_os_x'
  default['opsline-users']['home_base_directory'] = '/Users'
else
  default['opsline-users']['home_base_directory'] = '/home'
end
