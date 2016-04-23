name             'opsline-users'
maintainer       'Opsline'
maintainer_email 'cookbooks@opsline.com'
license          'All rights reserved'
description      'Creates groups and users from data bags'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

recipe 'opsline-users::default', 'Create all group and users from data bags'

%w( ubuntu debian redhat centos fedora mac_os_x amazon ).each do |os|
  supports os
end

source_url 'https://github.com/opsline/chef-opsline-users' if respond_to?(:source_url)
issues_url 'https://github.com/opsline/chef-opsline-users/issues' if respond_to?(:issues_url)
