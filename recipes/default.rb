#
# Cookbook Name:: opsline-users
# Recipe:: default
#
# Author:: Opsline
#
# Copyright 2014, OpsLine, LLC.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

class Chef::Recipe
  include Chef::OpslineUsers::Helpers
end

# list of groups for updates later
users_groups = {}


# create all the groups
get_all_groups().each do |group_name|
  g = get_group(group_name)

  # don't create if environment specified and not the current environment
  next if g.has_key?('environments') and ! g['environments'].include?(node.chef_environment)

  validated_action = validate_action(g['action'])
  validated_gid = validate_id(g['gid'])

  # add users list
  g['users'] = []
  # add to list of groups, only if created
  users_groups[g] if validated_action == :create

  Chef::Log.info("Creating group #{group_name}")

  group group_name do
    action validated_action
    gid validated_gid
  end
end


# create all the users
get_all_users().each do |user_name|
  u = get_user(user_name)

  # don't create if environment specified and not the current environment
  next if u.has_key?('environments') and ! u['environments'].include?(node.chef_environment)

  validated_action = validate_action(u['action'])
  validated_uid = validate_id(u['uid'])
  validated_gid = u.has_key?('gid') ? validate_id(u['gid']) : nil

  u['username'] ||= u['id']
  u['groups'].each do |g|
    users_groups[g] = { 'users' => [] } unless users_groups.has_key?(g)
    users_groups[g]['users'] << u['username'] unless validated_action == :remove
  end

  if u.has_key?('home')
    home_dir = u['home']
  else
    home_dir = "#{node['opsline-users']['home_base_directory']}/#{u['username']}"
  end

  manage_home = (home_dir == '/dev/null' ? false : true)

  Chef::Log.info("Creating user #{u['username']}")

  group u['username'] do
    gid validated_gid
    only_if { validated_gid.is_a?(Numeric) }
  end

  user u['username'] do
    action validated_action
    uid validated_uid
    gid validated_gid if u.has_key?('gid')
    shell u['shell']
    comment u['comment']
    password u['password'] if u.has_key?('password')
    supports manage_home: manage_home
    home home_dir
  end

  if manage_home
    if validated_action == :create and (u.has_key?('ssh_keys') or u.has_key?('ssh_private_key') or u.has_key?('ssh_public_key'))
      file_action = :create
    else
      file_action = :delete
    end
    file_owner = u.has_key?('uid') ? validated_uid : u['username']
    file_group = u.has_key?('gid') ? validated_gid : u['username']

    directory "#{home_dir}/.ssh" do
      action file_action
      owner file_owner
      group file_group
      mode 0700
      recursive true
    end

    template "#{home_dir}/.ssh/authorized_keys" do
      action file_action
      source 'authorized_keys.erb'
      owner file_owner
      group file_group
      mode 0600
      variables({
        ssh_keys: u['ssh_keys']
      })
      only_if { u.has_key?('ssh_keys') }
    end

    if u.has_key?('ssh_private_key')
      key_type = u['ssh_private_key'].include?('BEGIN RSA PRIVATE KEY') ? 'rsa' : 'dsa'
      template "#{home_dir}/.ssh/id_#{key_type}" do
        action file_action
        source 'private_key.erb'
        owner file_owner
        group file_group
        mode 0400
        variables({
          private_key: u['ssh_private_key']
        })
      end
    end

    if u.has_key?('ssh_public_key')
      key_type = u['ssh_public_key'].include?('ssh-rsa') ? 'rsa' : 'dsa'
      template "#{home_dir}/.ssh/id_#{key_type}.pub" do
        action file_action
        source 'public_key.pub.erb'
        owner file_owner
        group file_group
        mode 0400
        variables({
          public_key: u['ssh_public_key']
        })
      end
    end
  end

end


# add users to groups
users_groups.each do |group_name, g|
  group group_name do
    action :manage
    members g['users']
    append true
  end
end
