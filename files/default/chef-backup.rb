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
backup_status = `knife backup export -D #{backup_dir}/#{file_name}`

if $?.to_i != 0
  log.error "Failed to run knife backup command. \n Error: #{backup_status}"
  exit
end

# tar the backup
log.info 'compressing the backup...'
today = Date.today().strftime('%Y%m%d')
tar_status = `tar -czf #{backup_dir}/#{file_name}.#{today}.tar.gz -C #{backup_dir} #{file_name}`

if $?.to_i != 0
  log.error "Failed to tar the backup file. \n Error: #{tar_status}"
  exit
end

# remove the backup dir after compressing
log.info 'removing the backup dir...'
rm_status = `rm -rf #{backup_dir}/#{file_name}`

if $?.to_i != 0
  log.error "Failed to remove backup dir after compressing \n Error: #{rm_status}"
  exit
end

log.info "chef backup completeled successfully"