# backup settings
default['chef-backup']['backup_script_dir'] = '/usr/local/bin'
default['chef-backup']['backup_dir'] = '/opt/chef-backup'
default['chef-backup']['backup_log_file'] = '/var/log/chef-backup/backup.log'
default['chef-backup']['backup_cron']['hour'] = '0'
default['chef-backup']['backup_cron']['minute'] = '0'
default['chef-backup']['backup_cron']['weekday'] = '*'

# restore settings
default['chef-backup']['restore_script_dir'] = '/usr/local/bin'
default['chef-backup']['restore_file'] = '/opt/chef-backup/chef.backup.tar.gz'
default['chef-backup']['restore_log_file'] = '/var/log/chef-backup/restore.log'
default['chef-backup']['restore_cron']['hour'] = '0'
default['chef-backup']['restore_cron']['minute'] = '0'
default['chef-backup']['restore_cron']['weekday'] = '*'