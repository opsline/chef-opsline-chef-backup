#
# Cookbook Name:: opsline-chef-backup
# Recipe:: restore
#
# Copyright 2014, Opsline,LLC
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "#{node['chef-backup']['restore_script_dir']}/chef-restore.rb" do
  source "chef-restore.rb"
  mode "0700"
end

file node['chef-backup']['restore_log_file'] do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

cron "run_chef_restore" do
  hour  node['chef-backup']['restore_cron']['hour']
  minute  node['chef-backup']['restore_cron']['minute']
  weekday node['chef-backup']['restore_cron']['weekday']
  command "#{node['chef-backup']['restore_script_dir']}/chef-restore.rb -f #{node['chef-backup']['restore_file']} -l #{node['chef-backup']['restore_log_file']}"
end