#
# Cookbook Name:: opsline-chef-backup
# Recipe:: backup
#
# Copyright 2014, Opsline, LLC
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "#{node['chef-backup']['backup_script_dir']}/chef-backup.rb" do
  source "chef-backup.rb"
  mode "0700"
end


cron "run_chef_backup" do
  hour node['chef-backup']['backup_cron']['hour']
  minute node['chef-backup']['backup_cron']['minute']
  weekday node['chef-backup']['backup_cron']['weekday']
  command "#{node['chef-backup']['backup_script_dir']}/chef-backup.rb -d #{node['chef-backup']['backup_dir']} -l #{node['chef-backup']['log_dir']}/backup.log"
  user node['chef-backup']['backup_user']
end