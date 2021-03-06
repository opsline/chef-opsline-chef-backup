opsline-chef-backup Cookbook
============================
This cookbook has been created to perform routine and automated backups/restores of a chef server. It installs and configures chef backup or restore scripts on a chef server (depending on the recipe included in the run list). Cookbook uses the [knife backup plugin](https://github.com/mdxp/knife-backup) to perform backup and restore using custom scripts which are configured to execute via cron. 

The `opsline-chef-backup::backup` will configure cron to execute chef-backup.rb according to the attribute settings (daily at midnight by default) to perform a backup and create a timestamp-versioned tar.gz in `node['chef-backup']['backup_dir']`

The `opsline-chef-backup::restore` will configure cron to execute chef-restore.rb according to the attribute settings (daily at 1AM by default), and take a tar.gz specified in `node['chef-backup']['restore_file']` to perform a restore on the server.


Note: A method of transfering files between two chef servers has not been implemented. If backup is performed on one server, you would need to implement a method to transfer the backup archive to the second host (scp etc), which will perform the restore.

Requirements
------------
- Cron jobs use chef's embedded ruby, expected in /opt/chef/embedded/bin
- Create a chef client for backup/restore purposes (with admin privileges)
```bash
knife user create --admin chef-backup --password 'chef-backup'
```
- Create a databag called 'chef-backup' with item 'backup_client' containing the backup client cert (see below)

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

### Attributes
See `attributes/default.rb` for configuration options including backup directory, system user that will be created and under which cron will be configure to run etc.

### Data bag items
Chef backup client's private key (pem file) must be provided in a data bag called "chef-backup" and item "backup_client" as follows:
```json
{
  "id": "backup_client",
  "cert": "private_key"
}
```
The `private_key` should have the new lines converted to `\n` so as to create a single long string. On linux you can use this command to create such string from the pem file `tr "\n" "#" < pk_in.pem | sed 's/#/\\n/g' > pk_out.pem`

License and Authors
-------------------
* Author:: Roshan Singh

```text
Copyright 2014, OpsLine, LLC.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
