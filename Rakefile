require_relative 'lib/constants'

desc "Build site"
task :build do
  sh "bundle exec middleman build"
end

desc "Run development server"
task :server do
  sh "bundle exec middleman server"
end

desc "Upload documentation to server"
task :rsync => [:build] do
  sh "cd build && rsync -rv --progress --partial-dir=.rsync-partial --human-readable . " +
    "shell.phusion.nl:/home/phusion/websites/passenger_library/"
end

desc "Check broken links"
task :checklinks do
  # Ignore everything besides http://127.0.0.1:4567
  non_main_domain_regex = '^(?!http:\/\/127\.0\.0\.1:4567(\/|$))'
  # Ignore LiveReload stuff
  livereload_regex = '^http:\/\/127\.0\.0\.1:4567\/__rack'
  sh "linkchecker http://127.0.0.1:4567/" +
    " --ignore-url #{Shellwords.escape non_main_domain_regex}" +
    " --ignore-url #{Shellwords.escape livereload_regex}"
end
