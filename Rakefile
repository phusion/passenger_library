desc "Upload documentation to server"
task :rsync do
  sh "bundle exec middleman build"
  sh "cd build && rsync -rv --progress --partial-dir=.rsync-partial --human-readable . " +
    "shell.phusion.nl:/home/phusion/websites/passenger_library/"
end
