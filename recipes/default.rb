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

# create backup user
user node['chef-backup']['backup_user'] do
  supports :manage_home => true
  home "/home/#{node['chef-backup']['backup_user']}"
  shell '/bin/bash'
  action :create
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

# logrotate
logrotate_app 'chef-backup' do
  cookbook 'logrotate'
  path "#{node['chef-backup']['log_dir']}/*.log"
  options ['copytruncate', 'missingok', 'compress', 'notifempty', 'delaycompress']
  frequency 'daily'
  rotate 14
  enable :create
end
