#!/usr/bin/env ruby

# Opsline - Roshan Singh 5.30.2014
# Restores the latest using the "knife-backup" plugin 

require 'logger'
require 'date'
require 'optparse'

log = Logger.new(STDOUT)

# parse commandline options
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: knife-backup.rb [options]"

  opts.on("-f", "--backup-file FILE", String, "The backup tar.gz file to restore") do |v|
    if File.exists?(File.expand_path(v))
      options[:backup_file] = File.expand_path(v)
    else
      log.error "Backup archive does not exit!"
      exit
    end
  end

  opts.on("-l", "--log-file FILE", String, "File where logs will be written") do |v|
    f = File.expand_path(v)
    if File.directory?(File.dirname(f)) 
      # handle accidently specifying a log dir instead of file
      options[:log_file] =  File.directory?(f) ? f + '/restore.log' : f
    end
  end

end.parse!

# fail if no backup file specified
unless options.has_key?(:backup_file)
  log.error 'No backup file specified. Use -f FILE to point to a tar.gz file'
  exit
end

backup_file = options[:backup_file]

# log to file specified or default to same dir as backup file
log_file = options.has_key?(:log_file)? options[:log_file] : File.dirname(options[:backup_file]) + '/restore.log'
log = Logger.new(log_file)

# extract the archive
log.info 'extracting the backup archive...'
tar_status = `tar -xzf #{backup_file} -C #{File.dirname(backup_file)}`
if $?.to_i != 0
  log.error "Failed to extract the backup file. \n Error: #{tar_status}"
  exit
end

# run knife-backup restore
log.info 'running knife backup restore...'
backup_dir = File.dirname(backup_file) + '/chef.backup'

# using popen here so we can send Y for yes on prompt
IO.popen "knife backup restore -D #{backup_dir}", "r+" do |io|
  sleep(4) 
  io.puts "Y\n"
  io.close_write
  io.each do |line|
    log.info line.chomp
  end
end

if $?.to_i != 0
  log.error "restore failed on 'knife backup restore'!!!"
  exit
end

log.info 'chef backup restored successfully'