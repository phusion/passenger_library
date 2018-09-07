require_relative 'helpers/constants'

desc "Build site"
task :build do
  sh "bundle exec middleman build"
end

desc "Run development server"
task :server do
  sh "bundle exec middleman server"
end

task :rsync => :'rsync:production'

namespace :rsync do
  desc "Upload documentation to staging server"
  task :staging => [:build] do
    sh "cd build && rsync -rv --progress --partial-dir=.rsync-partial --human-readable . " +
      "passenger_library@staging.phusionpassenger.com:/var/www/passenger_library/"
  end

  desc "Upload documentation to production server"
  task :production => [:build] do
    sh "cd build && rsync -rv --progress --partial-dir=.rsync-partial --human-readable . " +
      "passenger_library@www.phusionpassenger.com:/var/www/passenger_library/"
  end
end

desc "Check broken links"
task :checklinks do
  # Ignore everything besides http://127.0.0.1:4567
  non_main_domain_regex = '^(?!http:\/\/127\.0\.0\.1:4567(\/|$))'
  # Ignore LiveReload stuff
  livereload_regex = '^http:\/\/127\.0\.0\.1:4567\/__rack'
  sh "linkchecker http://127.0.0.1:4567/sub/index.html" +
    " --ignore-url #{Shellwords.escape non_main_domain_regex}" +
    " --ignore-url #{Shellwords.escape livereload_regex}"
end
