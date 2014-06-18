#
# Cookbook Name:: opsline-chef-backup
# Recipe:: backup
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
