require 'serverspec'

set :backend, :exec

describe 'groups' do

  describe group('sysadmin') do
    it { should exist }
    it { should have_gid 1010 }
  end

  describe group('anothergroup') do
    it { should exist }
    it { should have_gid 1500 }
  end

  describe group('group1') do
    it { should exist }
    it { should have_gid 1900 }
  end

  describe group('notcreated') do
    it { should_not exist }
  end

  describe group('prod') do
    it { should_not exist }
  end

  describe group('qa') do
    it { should_not exist }
  end

end
