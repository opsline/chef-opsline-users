# opsline-users Cookbook

Manages OS groups and users using data bags.

This cookbook is based on and compatible with [Users](https://github.com/chef-cookbooks/users) cookbook. However, this implementation only has a single `default` recipe and allows to create arbitrary groups and users without resoring to wrapper cookbooks and recipes. It does not use LWRP with confusing actions.

## Features
* Create a group
* Create a user with SSH keys and add it to groups
* Store user data in encrypted data bags
* Ability to create users in specified environments only

## Requirements

* Chef 11+
* Data bags populated with user and group items
* Platforms
 * Ubuntu
 * Debian
 * Centos
 * RedHat
 * Amazon Linux

## Attributes

* `default['opsline-users']['users_databag_name']` - name of the data bag that will hold users
* `default['opsline-users']['groups_databag_name']` - name of the data bag that will hold groups
* `default['opsline-users']['home_base_directory']` - directory where home directories will be created

## Usage
This cookbook provides a single `default` recipe. It will create or remove groups and users defined in data bags. Simply add `default` recipe to the runlist to create user.

The following resources will be created for each user:
* home directory (if not disabled)
* password in shadow file (if provided)
* `.ssh/authorized_keys` file (if provided)
* RSA or DSA private SSH key (if provided)
* RSA or DSA public SSH key (if provided)

Data bag can be either encrypted or not.

### Groups
A sample group data bag item:
```json
{
  "id": "sysadmin",
  "action": "create",
  "groupname": "sysadmin",
  "gid": "1000",
  "environments": [
    "production"
  ]
}
```

#### Fields
* `id` - group name, or simply data bag item name if `groupname` provided
* `action` - either `create` or `remove` (to create or remove a group respectively)
* `gid` - group ID to be assigned to the group

#### Optinal fields
* `groupname` - if provided, it has a precedence over `id`
* `environments` - array of environments where the user will be created

#### Removing groups
Setting `action` field to `remove` will delete the group from the system. Users are not affected.

### Users
A sample user data bag item:
```json
{
  "id": "some_user",
  "action": "create",
  "username": "some_user",
  "uid": "1001",
  "git": "1001",
  "password": "$1$salt$hash",
  "ssh_keys": [
    "ssh-rsa AAAA... comment1",
    "ssh-rsa AAAA... comment2",
  ],
  "ssh_private_key": "-----BEGIN RSA PRIVATE KEY-----\n...\n",
  "ssh_public_key": "ssh-rsa AAAA... comment3",
  "groups": [
    "sysadmin"
  ],
  "environments": [
    "production"
  ],
  "shell": "/bin/bash",
  "home": "/home/some_user",
  "comment": "Some User"
}
```

#### Fields
* `id` - user name, or simply data bag item name if `username` provided
* `action` - either `create` or `remove` (to create or remove a group respectively)
* `shell` - shell to be configured for the user
* `comment` - real name of comment

#### Optional fields
* `username` - if provided, it has a precedence over `id`
* `uid` - user ID for the user
* `gid` - group ID for the primary user group
* `password` - hashed user password that will go into shadow file
* `ssh_keys` - array of SSH public keys that will be added to `authorized_keys` file
* `ssh_private_key` - RSA or DSA private key - must be a single line string (new lines replaced with `\n`)
* `ssh_public_key` - RDS or DSA public key
* `groups` - array of group names that user will be added to
* `environments` - array of environments where the user will be created
* `home` - home directory (not created if `/dev/null` provided)

#### Removing users
Setting `action` field to `remove` will delete the user from the system. Home directory with its entire content will be also deleted (along with all SSH keys).


#### User passwords
User passwords hashes can be generated with the following commands.
```bash
# SHA-512 (preferred - command available on Linux)
mkpasswd -m sha-512

# MD5 (when mkpasswd tool is not available)
openssl passwd -1 "plaintextpassword"

```

## License and Authors
* Author:: Radek Wierzbicki

```text
Copyright 2016, OpsLine, LLC.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
