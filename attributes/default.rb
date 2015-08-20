# default recipe
default['chef-backup']['log_dir'] = '/var/log/chef-backup'
default['chef-backup']['backup_dir'] = '/opt/chef-backup'
default['chef-backup']['backup_user'] = 'chef-backup'

# knife.rb config
default['chef-backup']['knife']['client_name'] = 'chef-backup'
default['chef-backup']['knife']['chef_server_url'] = 'https://localhost'
default['chef-backup']['knife']['data_bag_name'] = 'chef-users'

# backup recipe
default['chef-backup']['backup_script_dir'] = '/usr/local/bin'
default['chef-backup']['backup_cron']['hour'] = '0'
default['chef-backup']['backup_cron']['minute'] = '0'
default['chef-backup']['backup_cron']['weekday'] = '*'

# restore recipe
default['chef-backup']['restore_script_dir'] = '/usr/local/bin'
default['chef-backup']['restore_file'] = 'chef.backup.latest.tar.gz' # expected in node['chef-backup']['backup_dir']
default['chef-backup']['restore_cron']['hour'] = '1'
default['chef-backup']['restore_cron']['minute'] = '0'
default['chef-backup']['restore_cron']['weekday'] = '*'

# s3 sync recipe
default['chef-backup']['s3sync']['bucket'] = nil
default['chef-backup']['s3sync']['directory'] = 'chef'
default['chef-backup']['s3sync']['cron_hour'] = '1'
default['chef-backup']['s3sync']['cron_minute'] = '15'
default['chef-backup']['s3sync']['cron_weekday'] = '*'
