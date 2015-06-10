require "./lib/custom_helpers"
require "./lib/deployment_walkthrough_helpers"
helpers CustomHelpers
helpers DeploymentWalkthroughHelpers

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

define_deployment_walkthrough_pages do |*proxy_args|
  proxy(*proxy_args)
end

ignore "/walkthroughs/deploy/intro.html"
ignore "/walkthroughs/deploy/integration_mode.html"
ignore "/walkthroughs/deploy/open_source_vs_enterprise.html"
ignore "/walkthroughs/deploy/launch_server.html"
ignore "/walkthroughs/deploy/install_language_runtime.html"
ignore "/walkthroughs/deploy/install_passenger.html"
ignore "/walkthroughs/deploy/deploy_app.html"
ignore "/walkthroughs/deploy/conclusion.html"

###

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :markdown_engine, :kramdown
set :relative_links, true

activate :syntax
activate :relative_assets
activate :livereload, :port => 35730

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :asset_hash
end
