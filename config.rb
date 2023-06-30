require "./helpers/constants"
require "./lib/languages"
require "./helpers/custom_helpers"
require "./helpers/deployment_walkthrough_helpers"
require "./lib/kramdown_patch"
include CustomHelpers
include DeploymentWalkthroughHelpers

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

redir = Proc.new do |path, url|
  prefix = URI(config[:url_root]).path
  <<-END
    <html>
      <head>
        <link rel="canonical" href="#{prefix}#{url}" />
        <meta http-equiv=refresh content="0; url=#{prefix}#{url}" />
        <meta name="robots" content="noindex,follow" />
        <meta http-equiv="cache-control" content="no-cache" />
      </head>
      <body>
      </body>
    </html>
  END
end

redirect("index.html", {to: "/tutorials/what_is_passenger/index.html"}, &redir)
redirect('tutorials/index.html', {to: '/tutorials/what_is_passenger/index.html'}, &redir)
redirect('advanced_guides/index.html', {to: '/advanced_guides/install_and_upgrade/index.html'}, &redir)
redirect('references/index.html', {to: '/references/config_reference/index.html'}, &redir)

[:oss, :enterprise].each do |edition|
  proxy "/tutorials/deploy_to_production/launch_server/#{edition}/index.html",
        "/tutorials/deploy_to_production/launch_server/shared/index.html"
  [:digital_ocean,:aws].each do |platform|
    proxy "/tutorials/deploy_to_production/launch_server/#{edition}/#{platform}/index.html",
          "/tutorials/deploy_to_production/launch_server/shared/#{platform}/index.html"
  end
end

[:oss, :enterprise].each do |edition|
  [:digital_ocean,:ownserver,:aws].each do |platform|
    proxy "/tutorials/deploy_to_production/installations/#{edition}/#{platform}/index.html",
          "/tutorials/deploy_to_production/installations/#{edition}/platform.html"
    [:meteor,:ruby,:node,:python].each do |lang|
      proxy "/tutorials/deploy_to_production/installations/#{edition}/#{platform}/#{lang}/index.html",
            "/tutorials/deploy_to_production/installations/#{edition}/lang.html"
      [:apache,:nginx, :standalone].each do |integration|
        proxy "/tutorials/deploy_to_production/installations/#{edition}/#{platform}/#{lang}/#{integration}/index.html",
              "/tutorials/deploy_to_production/installations/#{edition}/shared/#{lang}/#{integration}/index.html"
      end
    end
  end
end

[:oss, :enterprise].each do |edition|
  [:digital_ocean,:ownserver,:aws].each do |platform|
    proxy "/tutorials/deploy_to_production/deploying_your_app/#{edition}/#{platform}/index.html",
          "/tutorials/deploy_to_production/deploying_your_app/platform.html"
    [:meteor,:ruby,:node,:python].each do |lang|
      proxy "/tutorials/deploy_to_production/deploying_your_app/#{edition}/#{platform}/#{lang}/index.html",
            "/tutorials/deploy_to_production/deploying_your_app/lang.html"
    end
  end
end

#################################################

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :fonts_dir,  'fonts'
set :markdown_engine, :kramdown
set :relative_links, true

activate :syntax
activate :relative_assets

configure :development do
  set :url_root, DEVELOPMENT_URL_ROOT
  set :hiring_banner, true
end

# Build-specific configuration
configure :build do
  set :url_root, PRODUCTION_URL_ROOT
  set :google_analytics, false
  set :hiring_banner, true

  activate :search_engine_sitemap
end

# external pipeline/webpack
activate :external_pipeline,
         name: :webpack,
         command: build? ? 'npm run build' : 'npm run watch',
         source: 'tmp/webpack',
         latency: 1
