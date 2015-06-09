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

DEPLOYMENT_WALKTHROUGH_LANGUAGES.each do |lang_spec|
  language_type = lang_spec[:language_type]
  locals = lang_spec

  # Introduction, select infrastructure
  proxy "/walkthroughs/deploy/#{language_type}/index.html",
    "/walkthroughs/deploy/intro.html",
    locals: lang_spec

  available_infrastructures(locals).each do |infra_spec|
    infrastructure_type = infra_spec[:infrastructure_type]
    prefix = "/walkthroughs/deploy/#{language_type}/#{infrastructure_type}"
    locals = lang_spec.merge(infra_spec)

    # Pick integration mode
    if available_integration_modes(locals).size > 1
      proxy "#{prefix}/integration_mode.html",
        "/walkthroughs/deploy/integration_mode.html",
        locals: locals
    end

    available_integration_modes(locals).each do |integration_mode_spec|
      integration_mode_type = integration_mode_spec[:integration_mode_type]
      prefix = "/walkthroughs/deploy/#{language_type}/#{infrastructure_type}/#{integration_mode_type}"
      locals = lang_spec.merge(infra_spec).merge(integration_mode_spec)

      # Open source vs Enterprise
      proxy "#{prefix}/open_source_vs_enterprise.html",
        "/walkthroughs/deploy/open_source_vs_enterprise.html",
        locals: locals

      PASSENGER_EDITIONS.each do |edition_spec|
        edition_type = edition_spec[:edition_type]
        prefix = "/walkthroughs/deploy/#{language_type}/#{infrastructure_type}/#{integration_mode_type}/#{edition_type}"
        locals = lang_spec.merge(infra_spec).merge(integration_mode_spec).merge(edition_spec)

        if needs_install_passenger?(locals)
          # Install Passenger
          proxy "#{prefix}/install_passenger.html",
            "/walkthroughs/deploy/install_passenger.html",
            locals: locals
        end

        # Deploy app
        proxy "#{prefix}/deploy_app.html",
          "/walkthroughs/deploy/deploy_app.html",
          locals: locals

        # Conclusion
        proxy "#{prefix}/conclusion.html",
          "/walkthroughs/deploy/conclusion.html",
          locals: locals
      end
    end
  end
end

ignore "/walkthroughs/deploy/intro.html"
ignore "/walkthroughs/deploy/integration_mode.html"
ignore "/walkthroughs/deploy/open_source_vs_enterprise.html"
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
