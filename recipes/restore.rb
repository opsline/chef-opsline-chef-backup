#
# Cookbook Name:: opsline-chef-backup
# Recipe:: restore
#
# Copyright 2014, Opsline, LLC
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'opsline-chef-backup::default'

cookbook_file "#{node['chef-backup']['restore_script_dir']}/chef-restore.rb" do
  source "chef-restore.rb"
  owner node['chef-backup']['backup_user']
  group node['chef-backup']['backup_user']
  mode 0750
end

cron "run_chef_restore" do
  hour node['chef-backup']['restore_cron']['hour']
  minute node['chef-backup']['restore_cron']['minute']
  weekday node['chef-backup']['restore_cron']['weekday']
  command "/opt/chef/embedded/bin/ruby #{node['chef-backup']['restore_script_dir']}/chef-restore.rb -f #{node['chef-backup']['backup_dir']}/#{node['chef-backup']['restore_file']} -l #{node['chef-backup']['log_dir']}/restore.log"
  user node['chef-backup']['backup_user']
end
