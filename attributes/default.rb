# default recipe
default['chef-backup']['log_dir'] = '/var/log/chef-backup'
default['chef-backup']['backup_dir'] = '/opt/chef-backup'
# system user
default['chef-backup']['backup_user'] = 'chef-backup'
# knife.rb config
default['chef-backup']['knife']['client_name'] = 'chef-backup'
default['chef-backup']['knife']['chef_server_url'] = 'https://localhost'

# backup recipe
default['chef-backup']['backup_script_dir'] = '/usr/local/bin'
default['chef-backup']['backup_cron']['hour'] = '0'
default['chef-backup']['backup_cron']['minute'] = '0'
default['chef-backup']['backup_cron']['weekday'] = '*'

# restore recipe
default['chef-backup']['restore_script_dir'] = '/usr/local/bin'
default['chef-backup']['restore_file'] = 'chef.backup.tar.gz' # expected in node['chef-backup']['backup_dir']
default['chef-backup']['restore_cron']['hour'] = '1'
default['chef-backup']['restore_cron']['minute'] = '0'
default['chef-backup']['restore_cron']['weekday'] = '*'