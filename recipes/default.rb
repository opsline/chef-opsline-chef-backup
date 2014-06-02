#
# Cookbook Name:: opsline-chef-backup
# Recipe:: default
#
# Copyright 2014, Opsline, LLC
#
# All rights reserved - Do Not Redistribute
#

# ensure ruby is installed
package 'ruby'

# install knife-backup plugin
chef_gem 'knife-backup'

# create backup user
user node['chef-backup']['backup_user']

# create knife config

# create knife cert from databag

# create dir where backup and restore scripts will append logs
directory node['chef-backup']['log_dir'] do
  owner node['chef-backup']['backup_user']
  group node['chef-backup']['backup_user']
  mode 00755
  action :create
end

# create dir where backups will be stored or restored from
directory node['chef-backup']['backup_dir'] do
  owner node['chef-backup']['backup_user']
  group node['chef-backup']['backup_user']
  mode 00755
  action :create
end