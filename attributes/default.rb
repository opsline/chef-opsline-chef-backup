# default recipe
default['chef-backup']['log_dir'] = '/var/log/chef-backup'
default['chef-backup']['backup_dir'] = '/opt/chef-backup'
default['chef-backup']['backup_user'] = 'chef-backup'

# backup recipe
default['chef-backup']['backup_script_dir'] = '/usr/local/bin'
default['chef-backup']['backup_cron']['hour'] = '*'
default['chef-backup']['backup_cron']['minute'] = '*/10'
default['chef-backup']['backup_cron']['weekday'] = '*'

# restore recipe
default['chef-backup']['restore_script_dir'] = '/usr/local/bin'
default['chef-backup']['restore_file'] = 'chef.backup.tar.gz' # expected in node['chef-backup']['backup_dir']
default['chef-backup']['restore_cron']['hour'] = '0'
default['chef-backup']['restore_cron']['minute'] = '0'
default['chef-backup']['restore_cron']['weekday'] = '*'