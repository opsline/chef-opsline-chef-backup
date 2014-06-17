opsline-chef-backup Cookbook
============================
Installs and configures chef backup and restore scripts on a chef server

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

### Data bag items
Backup client's private key (pem file) must be provided in data bag called "knife_cert" and item "client" as follows:
```json
{
  "id": "client",
  "cert": "..."
}
```
