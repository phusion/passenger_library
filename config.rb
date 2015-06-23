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
ignore "/walkthroughs/deploy/install_passenger_main.html"
ignore "/walkthroughs/deploy/install_passenger.html"
ignore "/walkthroughs/deploy/deploy_app_main.html"
ignore "/walkthroughs/deploy/deploy_app.html"
ignore "/walkthroughs/deploy/deploy_updates.html"
ignore "/walkthroughs/deploy/conclusion.html"


INTEGRATION_MODES.each do |integration_mode_spec|
  integration_mode_type = integration_mode_spec[:integration_mode_type]

  PASSENGER_EDITIONS.each do |edition_spec|
    edition_type = edition_spec[:edition_type]
    locals = integration_mode_spec.merge(edition_spec)

    proxy "/install/passenger_#{edition_type}_#{integration_mode_type}/index.html",
        "/install/install_passenger_main.html",
        locals: locals

    available_os_configs(locals).each do |os_config_spec|
      os_config = os_config_spec[:os_config_type]

      proxy "/install/passenger_#{edition_type}_#{integration_mode_type}/#{os_config}/index.html",
        "/install/install_passenger.html",
        locals: locals.merge(os_config_spec)
    end
  end
end

ignore "/install/install_passenger_main.html"
ignore "/install/install_passenger.html"

###

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :markdown_engine, :kramdown
set :relative_links, true
set :url_root, URL_ROOT
set :display_guides, true

activate :syntax
activate :relative_assets

configure :development do
  activate :livereload, :port => 35730
end

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :asset_hash

  activate :search_engine_sitemap
end
