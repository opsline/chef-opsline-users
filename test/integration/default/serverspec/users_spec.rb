require 'serverspec'

set :backend, :exec

describe 'users' do

  describe user('user1') do
    it { should exist }
  end

  describe user('user2') do
    it { should exist }
  end

  describe user('anotheruser') do
    it { should exist }
  end

  describe user('nokeyuser') do
    it { should exist }
  end

  describe user('notcreated') do
    it { should_not exist }
  end

end
