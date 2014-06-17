#
# Cookbook Name:: opsline-chef-backup
# Recipe:: backup
#
# Copyright 2014, Opsline, LLC
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'opsline-chef-backup::default'

cookbook_file "#{node['chef-backup']['backup_script_dir']}/chef-backup.rb" do
  source "chef-backup.rb"
  owner node['chef-backup']['backup_user']
  group node['chef-backup']['backup_user']
  mode 0750
end

cron "run_chef_backup" do
  hour node['chef-backup']['backup_cron']['hour']
  minute node['chef-backup']['backup_cron']['minute']
  weekday node['chef-backup']['backup_cron']['weekday']
  command "/opt/chef/embedded/bin/ruby #{node['chef-backup']['backup_script_dir']}/chef-backup.rb -d #{node['chef-backup']['backup_dir']} -l #{node['chef-backup']['log_dir']}/backup.log"
  user node['chef-backup']['backup_user']
end
