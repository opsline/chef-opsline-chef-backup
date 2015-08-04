#
# Cookbook Name:: opsline-chef-backup
# Recipe:: default
#
# Author:: Roshan Singh
#
# Copyright 2014, OpsLine, LLC.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# install knife-backup plugin
chef_gem 'knife-backup'

# create backup user
user node['chef-backup']['backup_user'] do
  supports :manage_home => true
  home "/home/#{node['chef-backup']['backup_user']}"
  shell '/bin/bash'
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
backup_client_dbi = Chef::EncryptedDataBagItem.load(node['chef-backup']['knife']['data_bag_name'], node['chef-backup']['knife']['client_name'])
file "/home/#{node['chef-backup']['backup_user']}/.chef/#{node['chef-backup']['knife']['client_name']}.pem" do
  content backup_client_dbi['cert']
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
