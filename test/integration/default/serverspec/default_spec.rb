require 'serverspec'

 include Serverspec::Helper::Exec
 include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin'
  end
end

describe user('chef-backup') do
  it { should exist }
end

describe user('chef-backup') do
  it { should belong_to_group 'chef-backup' }
end

describe user('chef-backup') do
  it { should have_home_directory '/home/chef-backup' }
end

describe file('/home/chef-backup/.chef') do
  it { should be_directory }
end

describe file('/home/chef-backup/.chef/knife.rb') do
  it { should be_file }
end

describe file('/home/chef-backup/.chef/chef-backup.pem') do
  it { should be_file }
end

describe file('/var/log/chef-backup') do
  it { should be_directory }
end

describe file('/opt/chef-backup') do
  it { should be_directory }
end