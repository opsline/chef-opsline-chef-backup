#
# Cookbook Name:: opsline-chef-backup
# Recipe:: backup
#
# Copyright 2014, Opsline, LLC
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/usr/local/bin/chef-backup.rb" do
  source "chef-backup.rb"
  mode "0700"
end

file node['chef-backup']['backup_log_file'] do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

cron "run_chef_backup" do
  hour  node['chef-backup']['backup_cron']['hour']
  minute  node['chef-backup']['backup_cron']['minute']
  weekday node['chef-backup']['backup_cron']['weekday']
  command "/usr/local/bin/chef-backup.rb -d #{node['chef-backup']['backup_dir']} -l #{node['chef-backup']['backup_log_file']}"
end