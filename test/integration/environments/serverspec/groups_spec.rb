require 'serverspec'

set :backend, :exec

describe 'groups' do

  describe group('sysadmin') do
    it { should exist }
  end

  describe group('prod') do
    it { should exist }
  end

  describe group('qa') do
    it { should_not exist }
  end

end
