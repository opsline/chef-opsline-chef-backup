#
# Cookbook Name:: opsline-chef-backup
# Recipe:: restore
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
include_recipe 'opsline-chef-backup::knife_config'

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
