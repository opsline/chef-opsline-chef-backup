#
# Cookbook Name:: opsline-chef-backup
# Recipe:: default
#
# Copyright 2014, Opsline, LLC
#
# All rights reserved - Do Not Redistribute
#

# install knife-backup plugin
chef_gem 'knife-backup'

# create backup user
user node['chef-backup']['backup_user'] do
  supports :manage_home => true
  home "/home/#{node['chef-backup']['backup_user']}"
  action :create
end

# create .chef dir in backup user's home for knife.rb config file
directory "/home/#{node['chef-backup']['backup_user']}/.chef" do
  owner node['chef-backup']['backup_user']
  group node['chef-backup']['backup_user']
  mode 0750
  action :create
end

# create knife.rb from template
template "/home/#{node['chef-backup']['backup_user']}/.chef/knife.rb" do
  source "knife.erb"
  owner node['chef-backup']['backup_user']
  group node['chef-backup']['backup_user']
  mode 0640
end

# create client pem from databag
file "/home/#{node['chef-backup']['backup_user']}/.chef/#{node['chef-backup']['knife']['client_name']}.pem" do
  content data_bag_item('chef-backup', 'backup_client')['cert']
  owner node['chef-backup']['backup_user']
  group node['chef-backup']['backup_user']
  mode 0600
end

# create dir where backup and restore scripts will append logs
directory node['chef-backup']['log_dir'] do
  owner node['chef-backup']['backup_user']
  group node['chef-backup']['backup_user']
  mode 0755
  action :create
end

# create dir where backups will be stored or restored from
directory node['chef-backup']['backup_dir'] do
  owner node['chef-backup']['backup_user']
  group node['chef-backup']['backup_user']
  mode 0755
  action :create
end
