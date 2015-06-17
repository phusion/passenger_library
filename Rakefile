require_relative 'lib/constants'

desc "Build site"
task :build do
  sh "bundle exec middleman build"
end

desc "Upload documentation to server"
task :rsync => [:build] do
  sh "cd build && rsync -rv --progress --partial-dir=.rsync-partial --human-readable . " +
    "shell.phusion.nl:/home/phusion/websites/passenger_library/"
end
