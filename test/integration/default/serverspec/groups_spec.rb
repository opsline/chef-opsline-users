require 'serverspec'

set :backend, :exec

describe 'groups' do

  describe group('sysadmin') do
    it { should exist }
  end

  describe group('anothergroup') do
    it { should exist }
  end

  describe group('notcreated') do
    it { should_not exist }
  end

end
