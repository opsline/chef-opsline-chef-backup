opsline-chef-backup Cookbook
============================
Installs and configures chef backup or restore scripts on a chef server (depending on the recipe included in the run list). 
This cookbook uses the [knife backup plugin](https://github.com/mdxp/knife-backup) to perform backup and restore using custom scripts which can be configured to execute via cron. 

The `opsline-chef-backup::backup` will configure cron to execute chef-backup.rb according to the attribute settings (daily at midnight by default) to perform a backup and create a timestamp-versioned tar.gz in `node['chef-backup']['backup_dir']`

The `opsline-chef-backup::restore` will configure cron to execute chef-restore.rb according to the attribute settings (daily at 1AM by default), and take a tar.gz specified in `node['chef-backup']['restore_file']` to perform a restore on the server. 

Requirements
------------
- Cron jobs use chef's embedded ruby, expected in /opt/chef/embedded/bin
- Create a chef client for backup/restore purposes (with admin privileges)
- Create a databag called 'knife_cert' with item 'client' containing the backup client cert (see below)

Usage
-----
Include `opsline-chef-backup::backup` or `opsline-chef-backup::restore` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[opsline-chef-backup::backup]"
  ]
}
```

Note: `opsline-chef-backup::default` recipe is automatically included in both backup and restore recipes therefore you do not need to include it in your run list.

### Data bag items
Backup client's private key (pem file) must be provided in data bag called "knife_cert" and item "client" as follows:
```json
{
  "id": "client",
  "cert": "..."
}
```
