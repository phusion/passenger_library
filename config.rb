require "./lib/constants"
require "./lib/languages"
require "./lib/custom_helpers"
require "./lib/deployment_walkthrough_helpers"
require "./lib/kramdown_patch"
helpers CustomHelpers
helpers DeploymentWalkthroughHelpers

#################################################
# Page options, layouts, aliases and proxies
#################################################

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

###### Deployment walkthrough ######

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

###### Installation, upgrade and uninstallation ######

INTEGRATION_MODES.each do |integration_mode_spec|
  integration_mode_type = integration_mode_spec[:integration_mode_type]

  proxy "/install/#{integration_mode_type}/index.html",
    "/install/index2.html",
    locals: integration_mode_spec
  proxy "/install/#{integration_mode_type}/install/index.html",
    "/install/install/step1.html",
    locals: integration_mode_spec
  proxy "/install/#{integration_mode_type}/upgrade/index.html",
    "/install/upgrade/edition_selection.html",
    locals: integration_mode_spec
  proxy "/install/#{integration_mode_type}/uninstall/index.html",
    "/install/uninstall/step1.html",
    locals: integration_mode_spec
  proxy "/install/#{integration_mode_type}/moving.html",
    "/install/moving.html",
    locals: integration_mode_spec
  proxy "/install/#{integration_mode_type}/noninteractive_install.html",
    "/install/noninteractive_install.html",
    locals: integration_mode_spec
  proxy "/install/#{integration_mode_type}/customizing_compilation_process.html",
    "/install/customizing_compilation_process.html",
    locals: integration_mode_spec
  proxy "/install/#{integration_mode_type}/migrating/migrating_from_p4_to_p5.html",
    "/install/migrating/migrating_from_p4_to_p5.html",
    locals: integration_mode_spec
  proxy "/install/#{integration_mode_type}/upgrading_from_oss_to_enterprise.html",
    "/install/upgrading_from_oss_to_enterprise.html",
    locals: integration_mode_spec
  proxy "/install/#{integration_mode_type}/apt_repo/index.html",
    "/install/apt_repo/apt_repo.html",
    locals: integration_mode_spec
  proxy "/install/#{integration_mode_type}/yum_repo/index.html",
    "/install/yum_repo/yum_repo.html",
    locals: integration_mode_spec

  PASSENGER_EDITIONS.each do |edition_spec|
    edition_type = edition_spec[:edition_type]
    locals = integration_mode_spec.merge(edition_spec)

    proxy "/install/#{integration_mode_type}/install/#{edition_type}/index.html",
      "/install/install/step2.html",
      locals: locals
    proxy "/install/#{integration_mode_type}/upgrade/#{edition_type}/index.html",
      "/install/upgrade/upgrade.html",
      locals: locals
    proxy "/install/#{integration_mode_type}/upgrade/#{edition_type}/tarball_upgrade.html",
      "/install/upgrade/tarball_upgrade.html",
      locals: locals
    proxy "/install/#{integration_mode_type}/uninstall/#{edition_type}/index.html",
      "/install/uninstall/step2.html",
      locals: locals

    available_os_configs(locals).each do |os_config_spec|
      os_config = os_config_spec[:os_config_type]
      locals = integration_mode_spec.merge(edition_spec).merge(os_config_spec)

      proxy "/install/#{integration_mode_type}/install/#{edition_type}/#{os_config}/index.html",
        "/install/install/step3.html",
        locals: locals
    end
  end
end

# Miscellaneous pages
proxy "/install/apt_repo/index.html",
  "/install/apt_repo/integration_mode_selection.html"
proxy "/install/yum_repo/index.html",
  "/install/yum_repo/integration_mode_selection.html"
proxy "/install/nginx/disable.html",
  "/install/disable.html",
  locals: INTEGRATION_MODE_NGINX
proxy "/install/apache/disable.html",
  "/install/disable.html",
  locals: INTEGRATION_MODE_APACHE
proxy "/install/install/index.html",
  "/install/install/integration_mode_and_edition_selection.html"
proxy "/install/upgrade/index.html",
  "/install/upgrade/integration_mode_and_edition_selection.html"

ignore "/install/index2.html"
ignore "/install/disable.html"
ignore "/install/moving.html"
ignore "/install/noninteractive_install.html"
ignore "/install/upgrading_from_oss_to_enterprise.html"
ignore "/install/customizing_compilation_process.html"
ignore "/install/apt_repo/integration_mode_selection.html"
ignore "/install/apt_repo/apt_repo.html"
ignore "/install/yum_repo/integration_mode_selection.html"
ignore "/install/yum_repo/yum_repo.html"
ignore "/install/install/integration_mode_and_edition_selection.html"
ignore "/install/install/step1.html"
ignore "/install/install/step2.html"
ignore "/install/install/step3.html"
ignore "/install/upgrade/integration_mode_and_edition_selection.html"
ignore "/install/upgrade/edition_selection.html"
ignore "/install/upgrade/upgrade.html"
ignore "/install/upgrade/tarball_upgrade.html"
ignore "/install/uninstall/step1.html"
ignore "/install/uninstall/step2.html"
ignore "/install/migrating/migrating_from_p4_to_p5.html"

###### Configuration and optimization ######

INTEGRATION_MODES.each do |integration_mode_spec|
  integration_mode_type = integration_mode_spec[:integration_mode_type]

  proxy "/config/#{integration_mode_type}/index.html",
    "/config/index2.html",
    locals: integration_mode_spec
  proxy "/config/#{integration_mode_type}/intro.html",
    "/config/intro.html",
    locals: integration_mode_spec
  proxy "/config/#{integration_mode_type}/dynamic_scaling_vs_fixed_app_processes/index.html",
    "/config/dynamic_scaling_vs_fixed_app_processes/language_selection.html",
    locals: integration_mode_spec
  proxy "/config/#{integration_mode_type}/optimization/index.html",
    "/config/optimization/optimization.html",
    locals: integration_mode_spec
  proxy "/config/#{integration_mode_type}/tuning_sse_and_websockets/index.html",
    "/config/tuning_sse_and_websockets/tuning_sse_and_websockets.html",
    locals: integration_mode_spec
  proxy "/config/#{integration_mode_type}/cloud_licensing_configuration/index.html",
    "/config/cloud_licensing_configuration/cloud_licensing_configuration.html",
    locals: integration_mode_spec
  proxy "/config/#{integration_mode_type}/reference/index.html",
    "/config/reference/reference.html",
    locals: integration_mode_spec

  SUPPORTED_LANGUAGES.each do |language_spec|
    language_type = language_spec[:language_type]

    proxy "/config/#{integration_mode_type}/dynamic_scaling_vs_fixed_app_processes/#{language_type}/index.html",
      "/config/dynamic_scaling_vs_fixed_app_processes/dynamic_scaling_vs_fixed_app_processes.html",
      locals: integration_mode_spec.merge(language_spec)
  end
end

proxy "/config/optimization/index.html",
  "/config/optimization/integration_mode_selection.html"
proxy "/config/tuning_sse_and_websockets/index.html",
  "/config/tuning_sse_and_websockets/integration_mode_selection.html"
proxy "/config/cloud_licensing_configuration/index.html",
  "/config/cloud_licensing_configuration/integration_mode_selection.html"

ignore "/config/index2.html"
ignore "/config/intro.html"
ignore "/config/dynamic_scaling_vs_fixed_app_processes/language_selection.html"
ignore "/config/dynamic_scaling_vs_fixed_app_processes/dynamic_scaling_vs_fixed_app_processes.html"
ignore "/config/optimization/optimization.html"
ignore "/config/optimization/integration_mode_selection.html"
ignore "/config/tuning_sse_and_websockets/tuning_sse_and_websockets.html"
ignore "/config/tuning_sse_and_websockets/integration_mode_selection.html"
ignore "/config/cloud_licensing_configuration/cloud_licensing_configuration.html"
ignore "/config/cloud_licensing_configuration/integration_mode_selection.html"
ignore "/config/reference/reference.html"

###### Deployment, scaling and high availability ######

INTEGRATION_MODES.each do |integration_mode_spec|
  integration_mode_type = integration_mode_spec[:integration_mode_type]

  proxy "/deploy/#{integration_mode_type}/index.html",
    "/deploy/index2.html",
    locals: integration_mode_spec

  proxy "/deploy/#{integration_mode_type}/user_sandboxing.html",
    "/deploy/user_sandboxing.html",
    locals: integration_mode_spec
  proxy "/deploy/#{integration_mode_type}/deployment_error_resistance.html",
    "/deploy/deployment_error_resistance.html",
    locals: integration_mode_spec


  if integration_mode_type == :nginx || integration_mode_type == :apache
    proxy "/deploy/#{integration_mode_type}/flying_passenger.html",
      "/deploy/flying_passenger.html",
      locals: integration_mode_spec
  end

  proxy "/deploy/#{integration_mode_type}/deploy/index.html",
    "/deploy/deploy/language_selection.html",
    locals: integration_mode_spec
  proxy "/deploy/#{integration_mode_type}/automating_app_updates/index.html",
    "/deploy/automating_app_updates/language_selection.html",
    locals: integration_mode_spec
  proxy "/deploy/#{integration_mode_type}/zero_downtime_redeployments/index.html",
    "/deploy/zero_downtime_redeployments/language_selection.html",
    locals: integration_mode_spec
  SUPPORTED_LANGUAGES.each do |language_spec|
    locals = integration_mode_spec.merge(language_spec)

    proxy "/deploy/#{integration_mode_type}/deploy/#{language_spec[:language_type]}/index.html",
      "/deploy/deploy/deploy.html",
      locals: locals
    proxy "/deploy/#{integration_mode_type}/automating_app_updates/#{language_spec[:language_type]}/index.html",
      "/deploy/automating_app_updates/automating_app_updates.html",
      locals: locals
    proxy "/deploy/#{integration_mode_type}/zero_downtime_redeployments/#{language_spec[:language_type]}/index.html",
      "/deploy/zero_downtime_redeployments/zero_downtime_redeployments.html",
      locals: locals
  end
end

ignore "/deploy/index2.html"
ignore "/deploy/deploy/language_selection.html"
ignore "/deploy/deploy/deploy.html"
ignore "/deploy/automating_app_updates/language_selection.html"
ignore "/deploy/automating_app_updates/automating_app_updates.html"
ignore "/deploy/zero_downtime_redeployments/language_selection.html"
ignore "/deploy/zero_downtime_redeployments/zero_downtime_redeployments.html"
ignore "/deploy/user_sandboxing.html"
ignore "/deploy/zero_downtime_redeployments.html"
ignore "/deploy/flying_passenger.html"
ignore "/deploy/deployment_error_resistance.html"

###### Administration and troubleshooting ######

INTEGRATION_MODES.each do |integration_mode_spec|
  integration_mode_type = integration_mode_spec[:integration_mode_type]

  proxy "/admin/#{integration_mode_type}/index.html",
    "/admin/index2.html",
    locals: integration_mode_spec
  proxy "/admin/#{integration_mode_type}/troubleshooting/index.html",
    "/admin/troubleshooting/language_selection.html",
    locals: integration_mode_spec
  SUPPORTED_LANGUAGES.each do |language_spec|
    proxy "/admin/#{integration_mode_type}/troubleshooting/#{language_spec[:language_type]}/index.html",
      "/admin/troubleshooting/troubleshooting.html",
      locals: integration_mode_spec.merge(language_spec)
  end
  proxy "/admin/#{integration_mode_type}/debugging_console/index.html",
    "/admin/debugging_console/language_selection.html",
    locals: integration_mode_spec
  proxy "/admin/#{integration_mode_type}/debugging_console/ruby/index.html",
    "/admin/debugging_console/ruby.html",
    locals: integration_mode_spec.merge(LANG_RUBY)
  proxy "/admin/#{integration_mode_type}/debugging_console/nodejs/index.html",
    "/admin/debugging_console/nodejs.html",
    locals: integration_mode_spec.merge(LANG_NODEJS)
  proxy "/admin/#{integration_mode_type}/admin_tools.html",
    "/admin/admin_tools.html",
    locals: integration_mode_spec
  proxy "/admin/#{integration_mode_type}/request_individual_processes.html",
    "/admin/request_individual_processes.html",
    locals: integration_mode_spec
  proxy "/admin/#{integration_mode_type}/overall_status_report.html",
    "/admin/overall_status_report.html",
    locals: integration_mode_spec
  proxy "/admin/#{integration_mode_type}/restart_app.html",
    "/admin/restart_app.html",
    locals: integration_mode_spec
  proxy "/admin/#{integration_mode_type}/log_file/index.html",
    "/admin/log_file/log_file.html",
    locals: integration_mode_spec
  proxy "/admin/#{integration_mode_type}/log_rotation.html",
    "/admin/log_rotation.html",
    locals: integration_mode_spec
  proxy "/admin/#{integration_mode_type}/stuck_apps.html",
    "/admin/stuck_apps.html",
    locals: integration_mode_spec
  proxy "/admin/#{integration_mode_type}/memory_leaks.html",
    "/admin/memory_leaks.html",
    locals: integration_mode_spec
end

proxy "/admin/log_file/index.html",
  "/admin/log_file/integration_mode_selection.html"

ignore "/admin/index2.html"
ignore "/admin/admin_tools.html"
ignore "/admin/request_individual_processes.html"
ignore "/admin/overall_status_report.html"
ignore "/admin/restart_app.html"
ignore "/admin/log_file/log_file.html"
ignore "/admin/log_file/integration_mode_selection.html"
ignore "/admin/log_rotation.html"
ignore "/admin/stuck_apps.html"
ignore "/admin/memory_leaks.html"
ignore "/admin/troubleshooting/language_selection.html"
ignore "/admin/troubleshooting/troubleshooting.html"
ignore "/admin/debugging_console/language_selection.html"
ignore "/admin/debugging_console/ruby.html"
ignore "/admin/debugging_console/nodejs.html"

###### In-depth ######

SUPPORTED_LANGUAGES.each do |language_spec|
  language_type = language_spec[:language_type]
  proxy "/indepth/#{language_type}/index.html",
    "/indepth/index2.html",
    locals: language_spec
  INTEGRATION_MODES.each do |integration_mode_spec|
    integration_mode_type = integration_mode_spec[:integration_mode_type]

    proxy "/indepth/#{language_type}/app_autodetection/index.html",
      "/indepth/app_autodetection/index.html",
      locals: integration_mode_spec.merge(language_spec)
    proxy "/indepth/#{language_type}/app_autodetection/#{integration_mode_type}/index.html",
      "/indepth/app_autodetection/app_autodetection.html",
      locals: integration_mode_spec.merge(language_spec)
    proxy "/indepth/#{language_type}/dynamic_scaling_of_app_processes/#{integration_mode_type}/index.html",
      "/indepth/dynamic_scaling_of_app_processes/dynamic_scaling_of_app_processes.html",
      locals: integration_mode_spec.merge(language_spec)
  end

  proxy "/indepth/#{language_type}/request_load_balancing.html",
    "/indepth/request_load_balancing/request_load_balancing.html",
    locals: language_spec
  proxy "/indepth/#{language_type}/dynamic_scaling_of_app_processes/index.html",
    "/indepth/dynamic_scaling_of_app_processes/integration_mode_selection.html",
    locals: language_spec
  proxy "/indepth/#{language_type}/apache_per_request_envvars.html",
    "/indepth/apache_per_request_envvars/apache_per_request_envvars.html",
    locals: language_spec
end

proxy "/indepth/ruby/out_of_band_work.html",
  "/indepth/out_of_band_work.html",
  locals: LANG_RUBY
proxy "/indepth/ruby/spawn_methods/index.html",
  "/indepth/spawn_methods/spawn_methods.html",
  locals: LANG_RUBY
proxy "/indepth/nodejs/reverse_port_binding.html",
  "/indepth/reverse_port_binding.html",
  locals: LANG_NODEJS
proxy "/indepth/nodejs/secure_http_headers.html",
  "/indepth/secure_http_headers.html",
  locals: LANG_NODEJS
proxy "/indepth/meteor/secure_http_headers.html",
  "/indepth/secure_http_headers.html",
  locals: LANG_METEOR

ignore "/indepth/index2.html"
ignore "/indepth/app_autodetection/app_autodetection.html"
ignore "/indepth/dynamic_scaling_of_app_processes/dynamic_scaling_of_app_processes.html"
ignore "/indepth/request_load_balancing/request_load_balancing.html"
ignore "/indepth/dynamic_scaling_of_app_processes/integration_mode_selection.html"
ignore "/indepth/apache_per_request_envvars/apache_per_request_envvars.html"
ignore "/indepth/out_of_band_work.html"
ignore "/indepth/spawn_methods/spawn_methods.html"
ignore "/indepth/reverse_port_binding.html"
ignore "/indepth/secure_http_headers.html"

###### Union Station logging ######

SUPPORTED_LANGUAGES.each do |language_spec|
  language_type = language_spec[:language_type]
  proxy "/unionstation/#{language_type}/index.html",
    "/unionstation/index2.html",
    locals: language_spec

  proxy "/unionstation/#{language_type}/ust_logging_api.html",
    "/unionstation/ust_logging_api.html",
    locals: language_spec
end

ignore "/unionstation/index2.html"
ignore "/unionstation/ust_logging_api.html"

#################################################

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :markdown_engine, :kramdown
set :relative_links, true
set :display_guides, true

activate :syntax
activate :relative_assets

configure :development do
  set :url_root, DEVELOPMENT_URL_ROOT
  activate :livereload, :port => 35730
end

# Build-specific configuration
configure :build do
  set :url_root, PRODUCTION_URL_ROOT
  set :google_analytics, true

  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :asset_hash

  activate :search_engine_sitemap
end
