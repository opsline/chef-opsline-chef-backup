require 'serverspec'

 include Serverspec::Helper::Exec
 include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin'
  end
end

describe file('/usr/local/bin/chef-restore.rb') do
  it { should be_file }
end

describe cron do
  it { should have_entry('/opt/chef/embedded/bin/ruby /usr/local/bin/chef-restore.rb').with_user('chef-backup')  }
end