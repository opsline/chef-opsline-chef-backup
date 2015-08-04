#!/usr/bin/env ruby

# Opsline - Roshan Singh 5.27.2014
# Backs up chef server data using the "knife-backup" plugin

require 'logger'
require 'date'
require 'optparse'

log = Logger.new(STDOUT)

# parse commandline options
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: knife-backup.rb [options]"

  opts.on("-d", "--backup-dir DIR", String, "Directory where backup files (tar.gz archives) will be placed") do |v|
    if File.directory?(v)
      options[:backup_dir] = File.expand_path(v)
    else
      log.error "Backup directory does not exit!"
      exit
    end
  end

  opts.on("-l", "--log-file FILE", String, "File where logs will be written") do |v|
    f = File.expand_path(v)
    if File.directory?(File.dirname(f)) 
      # handle accidently specifying a log dir instead of file
      options[:log_file] =  File.directory?(f) ? f + '/backup.log' : f
    end
  end

end.parse!

unless options.has_key?(:backup_dir)
  options[:backup_dir] = File.expand_path('.')
end

# log to file specified or default to backup dir
log_file = options.has_key?(:log_file)? options[:log_file] : options[:backup_dir] + '/backup.log'
log = Logger.new(log_file)


# set some options
backup_dir = options[:backup_dir]
file_name = 'chef.backup'

# run knife backup
log.info 'running knife backup export...'
status = `knife backup export -D #{backup_dir}/#{file_name}`

unless $?.to_i == 0
  log.error "Failed to run knife backup command. \n Error: #{status}"
  exit
end

# tar the backup
log.info 'compressing the backup...'
ts = Time.now.to_i
status = `tar -czf #{backup_dir}/#{file_name}.#{ts}.tar.gz -C #{backup_dir} #{file_name}`

unless $?.to_i == 0
  log.error "Failed to tar the backup file. \n Error: #{status}"
  exit
end

`rm -f #{backup_dir}/#{file_name}.latest.tar.gz`
`ln -s #{backup_dir}/#{file_name}.#{ts}.tar.gz #{backup_dir}/#{file_name}.latest.tar.gz`

# remove the backup dir after compressing
log.info 'removing the backup dir...'
`rm -rf #{backup_dir}/#{file_name}`

# remove old backups
log.info 'removing old backups...'
`/usr/bin/find #{backup_dir} -type f -mtime +14 -delete`

log.info "chef backup completeled successfully"
