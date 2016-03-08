require 'serverspec'

set :backend, :exec

describe 'users' do

  describe group('user1') do
    it { should exist }
  end
  describe user('user1') do
    it { should exist }
    it { should belong_to_primary_group 'user1' }
    it { should belong_to_group 'sysadmin' }
    it { should_not belong_to_group 'anothergroup' }
    it { should have_home_directory '/home/user1' }
    it { should have_login_shell '/bin/bash' }
    its(:encrypted_password) { should match(/htZGTLOnWuetSrgyWZkJm1/) }
    it { should have_authorized_key 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDjZQZjPPDG4p5udRhPZ4bM8usdx47BSoe8EZDq662vlPoudMPCHV80P3nYUQSofQxyzZmRdQnmETvap0zYADJp3qUdVTu/GjzonGAH0rWbhgxVDrkp0YwdSzCUZLehLObIyPXQzaOIsHsMwJ0aRPi2vUJB8d95joh+4DeC0UtCZeug2KT0VJR2V/UMVxj7emrpoh8tOlZs9pP7H5zXyvMIw9NtW1xsKn29iyewAtEKCDAt0FHLHakDCjLmzDivwwLJOf4qnu1ox+9aStvarUkCdTOTXP7hO5H3/v6VlhVtMK4HHK2j9h2jxOKuZn2NYpOcM1oCefNpPWd7uCMqGM4J user1@localhost' }
    it { should have_authorized_key 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWoCviR1TIeginRGG1vf45y6Tye69cmPOuKP3EKwQxLh/PEfBXAR1j4fSzqyTpn1rhcSTAe8jzJ1Eo9A+s6p1m+QpMCsHIWKPW3TFdnximDR6JxFKx6nayZhOLggeWA0XEhZY9XCcLlw9AatnXdrLNBv6Kfsl767KZ+M6l8aMAR2bCyFYo0TVZti0qQWPXcLgVPQ6KPMKZ+eDxWx9oLmctDpG5Sf2QYAHv9juFwetwPlcX5RFTi1IEjaCZBXMklrQ5YRxc4M4XErryjnA79gksoi53zUIELmUHD7rU5wwhdicFM6dkjdG4htbp8TYFKC1hhRfe1dYo8UWMrlazemx1 user1@localhost' }
  end
  describe file('/home/user1') do
    it { should be_directory }
  end
  describe file('/home/user1/.ssh') do
    it { should be_directory }
  end
  describe file('/home/user1/.ssh/authorized_keys') do
    it { should be_file }
    its(:content) { should match /GjzonGAH0rWbhgxVDrkp0YwdSzCUZLehLOb/ }
    its(:content) { should match /QpMCsHIWKPW3TFdnximDR6JxFKx6nayZhOL/ }
    its(:content) { should match /user1/ }
    it { should be_mode 600 }
    it { should be_owned_by 'user1' }
    it { should be_grouped_into 'user1' }
  end
  describe file('/home/user1/.ssh/id_rsa') do
    it { should be_file }
    its(:content) { should match /RSA/ }
    its(:content) { should match /d5bUYoeuxVt0oDjqXwuBliyHAvQhxH0QGTDpIJDR91cecASGn9pdFC1HBndJ/ }
    it { should be_mode 400 }
    it { should be_owned_by 'user1' }
    it { should be_grouped_into 'user1' }
  end
  describe file('/home/user1/.ssh/id_rsa.pub') do
    it { should be_file }
    its(:content) { should match /ssh-rsa/ }
    its(:content) { should match /Ag9ZDnd7lcYYLJ32l8Xj1kfplXEanOitLYT8r8/ }
    its(:content) { should match /keycomment/ }
    it { should be_mode 400 }
    it { should be_owned_by 'user1' }
    it { should be_grouped_into 'user1' }
  end
  describe file('/home/user2/.ssh/id_dsa') do
    it { should_not exist }
  end
  describe file('/home/user2/.ssh/id_dsa.pub') do
    it { should_not exist }
  end


  describe group('user2') do
    it { should exist }
    it { should have_gid 610 }
  end
  describe user('user2') do
    it { should exist }
    it { should have_uid 1010 }
    it { should belong_to_primary_group 'user2' }
    it { should belong_to_group 'sysadmin' }
    it { should belong_to_group 'anothergroup' }
    it { should have_home_directory '/var/lib/user2' }
    it { should have_login_shell '/bin/bash' }
    its(:encrypted_password) { should match(/S2QijtFBqJTWBPlKPbTBw/) }
    it { should have_authorized_key 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDfCCVe3ln+qrsBRMH2Jq5MF44Dk8tiD/NAtnx+e47St9z5oMjCXENCjQ9UGctnDYUHfr50ifb9zH1pmTPI+X0N+0s81AvtHm0cPYFvZkt870QWG4TvImBLzfc/QlpiFpxzJnsvOF6hbI6gjwX0tg6VklwS+g/YrCzS7ZzLimiviR42twC385c62QmGoJKzmE/0VvPly7TnDWsMUU4OtixOMzvGf8UvUOvh+m1gbN5GtcDuUkXFH9HbwW+6WYPwEk2UKidFijF8CdBg9pSOGZNLDhWQpEz1CcOGdWQzRRZiQTKUzZCEX4Gg6VK7fiiqnBT7WA01hmIBmnZhdqMODGYF user2@localhost' }
  end
  describe file('/var/lib/user2') do
    it { should be_directory }
  end
  describe file('/var/lib/user2/.ssh') do
    it { should be_directory }
  end
  describe file('/var/lib/user2/.ssh/authorized_keys') do
    it { should be_file }
    its(:content) { should match /QlpiFpxzJnsvOF6hbI6gjwX0tg6VklwS/ }
    its(:content) { should match /user2/ }
    it { should be_mode 600 }
    it { should be_owned_by 'user2' }
    it { should be_grouped_into 'user2' }
  end
  describe file('/var/lib/user2/.ssh/id_rsa') do
    it { should_not exist }
  end
  describe file('/var/lib/user2/.ssh/id_rsa.pub') do
    it { should_not exist }
  end
  describe file('/var/lib/user2/.ssh/id_dsa') do
    it { should be_file }
    its(:content) { should match /DSA/ }
    its(:content) { should match /96DUHvrWBAv9EH1G5zK3CRLEqsLfmHEifz/ }
    it { should be_mode 400 }
    it { should be_owned_by 'user2' }
    it { should be_grouped_into 'user2' }
  end
  describe file('/var/lib/user2/.ssh/id_dsa.pub') do
    it { should be_file }
    its(:content) { should match /ssh-dss/ }
    its(:content) { should match /4ekmhDreDz68bcrwWmFQmqFiLn2f00VlB6JC2FDzznHdHH0YIOlSE1viS4K/ }
    its(:content) { should match /keycomment/ }
    it { should be_mode 400 }
    it { should be_owned_by 'user2' }
    it { should be_grouped_into 'user2' }
  end


  describe group('user3') do
    it { should exist }
  end
  describe user('user3') do
    it { should exist }
    it { should belong_to_primary_group 'user3' }
    it { should belong_to_group 'anothergroup' }
    it { should have_home_directory '/home/user3' }
    it { should have_login_shell '/bin/sh' }
  end
  describe file('/home/user3') do
    it { should be_directory }
  end
  describe file('/home/user3/.ssh') do
    it { should be_directory }
  end
  describe file('/home/user3/.ssh/authorized_keys') do
    it { should be_file }
    its(:content) { should match /Generated by Chef/ }
    it { should be_mode 600 }
    it { should be_owned_by 'user3' }
    it { should be_grouped_into 'user3' }
  end
  describe file('/home/user3/.ssh/id_rsa') do
    it { should_not exist }
  end
  describe file('/home/user3/.ssh/id_rsa.pub') do
    it { should_not exist }
  end
  describe file('/home/user3/.ssh/id_dsa') do
    it { should_not exist }
  end
  describe file('/home/user3/.ssh/id_dsa.pub') do
    it { should_not exist }
  end


  describe group('anotheruser') do
    it { should exist }
  end
  describe user('anotheruser') do
    it { should exist }
    it { should belong_to_primary_group 'anotheruser' }
    it { should belong_to_group 'anothergroup' }
    it { should_not belong_to_group 'sysadmin' }
    it { should have_home_directory '/home/anotheruser' }
    it { should have_login_shell '/bin/bash' }
    its(:encrypted_password) { should match(/htZGTLOnWuetSrgyWZkJm1/) }
    it { should have_authorized_key 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDjZQZjPPDG4p5udRhPZ4bM8usdx47BSoe8EZDq662vlPoudMPCHV80P3nYUQSofQxyzZmRdQnmETvap0zYADJp3qUdVTu/GjzonGAH0rWbhgxVDrkp0YwdSzCUZLehLObIyPXQzaOIsHsMwJ0aRPi2vUJB8d95joh+4DeC0UtCZeug2KT0VJR2V/UMVxj7emrpoh8tOlZs9pP7H5zXyvMIw9NtW1xsKn29iyewAtEKCDAt0FHLHakDCjLmzDivwwLJOf4qnu1ox+9aStvarUkCdTOTXP7hO5H3/v6VlhVtMK4HHK2j9h2jxOKuZn2NYpOcM1oCefNpPWd7uCMqGM4J user1@localhost' }
  end
  describe file('/home/anotheruser') do
    it { should be_directory }
  end
  describe file('/home/anotheruser/.ssh') do
    it { should be_directory }
  end
  describe file('/home/anotheruser/.ssh/authorized_keys') do
    it { should be_file }
    its(:content) { should match /VDrkp0YwdSzCUZLehLObIyPXQzaOIsHsMwJ0aRPi2/ }
    its(:content) { should match /anotheruser/ }
    it { should be_mode 600 }
    it { should be_owned_by 'anotheruser' }
    it { should be_grouped_into 'anotheruser' }
  end
  describe file('/home/anotheruser/.ssh/id_rsa') do
    it { should_not exist }
  end
  describe file('/home/anotheruser/.ssh/id_rsa.pub') do
    it { should_not exist }
  end
  describe file('/home/anotheruser/.ssh/id_dsa') do
    it { should_not exist }
  end
  describe file('/home/anotheruser/.ssh/id_dsa.pub') do
    it { should_not exist }
  end


  describe group('nokeyuser') do
    it { should exist }
  end
  describe user('nokeyuser') do
    it { should exist }
    it { should belong_to_primary_group 'nokeyuser' }
    it { should belong_to_group 'anothergroup' }
    it { should have_home_directory '/home/nokeyuser' }
    it { should have_login_shell '/bin/bash' }
    its(:encrypted_password) { should match(/S2QijtFBqJTWBPlKPbTBw/) }
  end
  describe file('/home/nokeyuser') do
    it { should be_directory }
  end
  describe file('/home/nokeyuser/.ssh') do
    it { should_not exist }
  end
  describe file('/home/nokeyuser/.ssh/authorized_keys') do
    it { should_not exist }
  end
  describe file('/home/nokeyuser/.ssh/id_rsa') do
    it { should_not exist }
  end
  describe file('/home/nokeyuser/.ssh/id_rsa.pub') do
    it { should_not exist }
  end
  describe file('/home/nokeyuser/.ssh/id_dsa') do
    it { should_not exist }
  end
  describe file('/home/nokeyuser/.ssh/id_dsa.pub') do
    it { should_not exist }
  end

  describe group('notcreated') do
    it { should_not exist }
  end
  describe user('notcreated') do
    it { should_not exist }
  end
  describe file('/home/notcreated') do
    it { should_not exist }
  end
  describe file('/home/notcreated/.ssh') do
    it { should_not exist }
  end
  describe file('/home/notcreated/.ssh/authorized_keys') do
    it { should_not exist }
  end
  describe file('/home/notcreated/.ssh/id_rsa') do
    it { should_not exist }
  end
  describe file('/home/notcreated/.ssh/id_rsa.pub') do
    it { should_not exist }
  end
  describe file('/home/notcreated/.ssh/id_dsa') do
    it { should_not exist }
  end
  describe file('/home/notcreated/.ssh/id_dsa.pub') do
    it { should_not exist }
  end

  describe group('encrypteduser') do
    it { should exist }
  end
  describe user('encrypteduser') do
    it { should exist }
  end

end
