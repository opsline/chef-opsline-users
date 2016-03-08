require 'serverspec'

set :backend, :exec

describe 'users' do

  describe user('user1') do
    it { should exist }
  end

  describe user('produser') do
    it { should exist }
  end

  describe user('qauser') do
    it { should_not exist }
  end

  describe user('testuser') do
    it { should_not exist }
  end

end
