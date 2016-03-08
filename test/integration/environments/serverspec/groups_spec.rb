require 'serverspec'

set :backend, :exec

describe 'groups' do

  describe group('sysadmin') do
    it { should exist }
    it { should have_gid 1000 }
  end

  describe group('anothergroup') do
    it { should exist }
    it { should have_gid 1500 }
  end

  describe group('notcreated') do
    it { should_not exist }
  end

  describe group('prod') do
    it { should exist }
    it { should have_gid 1200 }
  end

  describe group('qa') do
    it { should_not exist }
  end

end
