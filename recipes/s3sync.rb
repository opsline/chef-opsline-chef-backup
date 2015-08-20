return if node['chef-backup']['s3sync']['bucket'].nil?

template "#{node['chef-backup']['backup_script_dir']}/chef-s3sync.sh" do
  source "chef-s3sync.sh.erb"
  owner node['chef-backup']['backup_user']
  group node['chef-backup']['backup_user']
  mode 0750
end

cron "sync_chef_backups" do
  hour node['chef-backup']['s3sync']['cron_hour']
  minute node['chef-backup']['s3sync']['cron_minute']
  weekday node['chef-backup']['s3sync']['cron_weekday']
  command "#{node['chef-backup']['backup_script_dir']}/chef-s3sync.sh >> #{node['chef-backup']['log_dir']}/s3sync.log 2>&1"
  user node['chef-backup']['backup_user']
end
