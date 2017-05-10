#
# Cookbook Name:: opsline-chef-backup
# Recipe:: chef_server_ctl_backup
#
# Author:: Scott Morris
#
# Copyright 2017, OpsLine, LLC.
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

include_recipe 'opsline-chef-backup::default'

SCRIPT_NAME='chef-server-ctl-backup'

template "#{node['chef-backup']['backup_script_dir']}/#{SCRIPT_NAME}.sh" do
  source "#{SCRIPT_NAME}.sh.erb"
  owner 'root'
  group 'root'
  mode 0754
end

cron "#{SCRIPT_NAME}_cron" do
  hour node['chef-backup']['backup_cron']['hour']
  minute node['chef-backup']['backup_cron']['minute']
  weekday node['chef-backup']['backup_cron']['weekday']
  command "#{node['chef-backup']['backup_script_dir']}/#{SCRIPT_NAME}.sh >> #{node['chef-backup']['log_dir']}/#{SCRIPT_NAME}.log 2>&1"
  user 'root'
end
