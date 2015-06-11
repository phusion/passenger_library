# Chapters:
#
# Introduction, select infrastructure
# Pick integration mode
# Open source vs Enterprise
# Launch a server
# Install language runtime
# Install Passenger
# Deploying the app
# Automating deployments
# Conclusion

module DeploymentWalkthroughHelpers
  DEPLOYMENT_WALKTHROUGH_LANGUAGES = [
    { language_type: :ruby,
      language_name: "Ruby",
      language_has_install_instructions: true },
    { language_type: :python,
      language_name: "Python",
      language_has_install_instructions: true },
    { language_type: :nodejs,
      language_name: "Node.js",
      language_has_install_instructions: false },
    { language_type: :iojs,
      language_name: "io.js",
      language_has_install_instructions: false },
    { language_type: :meteor,
      language_name: "Meteor",
      language_has_install_instructions: false }
  ]
  DEPLOYMENT_WALKTHROUGH_INFRASTRUCTURES = [
    { infrastructure_type: :aws,
      infrastructure_name: "AWS",
      infrastructure_name_with_determiner: "an AWS",
      infrastructure_long_name: "Amazon Web Services",
      infrastructure_has_launch_instructions: true,
      infrastructure_needs_install_language_runtime: true },
    { infrastructure_type: :heroku,
      infrastructure_name: "Heroku",
      infrastructure_name_with_determiner: "a Heroku",
      infrastructure_long_name: "Heroku",
      infrastructure_has_launch_instructions: false,
      infrastructure_needs_install_language_runtime: false },
    { infrastructure_type: :ownserver,
      infrastructure_name: "Linux/Unix",
      infrastructure_name_with_determiner: "a Linux/Unix",
      infrastructure_long_name: "Any hosting provider or infrastructure running Linux/Unix",
      infrastructure_has_launch_instructions: false,
      infrastructure_needs_install_language_runtime: true }
  ]
  PASSENGER_EDITIONS = [
    { edition_type: :oss, edition_name: "open source" },
    { edition_type: :enterprise, edition_name: "Enterprise" }
  ]


  def define_deployment_walkthrough_pages
    DEPLOYMENT_WALKTHROUGH_LANGUAGES.each do |lang_spec|
      language_type = lang_spec[:language_type]
      locals = lang_spec

      # Introduction, select infrastructure
      yield "/walkthroughs/deploy/#{language_type}/index.html",
        "/walkthroughs/deploy/intro.html",
        locals: lang_spec

      available_infrastructures(locals).each do |infra_spec|
        infrastructure_type = infra_spec[:infrastructure_type]
        prefix = "/walkthroughs/deploy/#{language_type}/#{infrastructure_type}"
        locals = lang_spec.merge(infra_spec)

        # Pick integration mode
        if available_integration_modes(locals).size > 1
          yield "#{prefix}/integration_mode.html",
            "/walkthroughs/deploy/integration_mode.html",
            locals: locals
        end

        available_integration_modes(locals).each do |integration_mode_spec|
          integration_mode_type = integration_mode_spec[:integration_mode_type]
          prefix = "/walkthroughs/deploy/#{language_type}/#{infrastructure_type}/#{integration_mode_type}"
          locals = lang_spec.merge(infra_spec).merge(integration_mode_spec)

          # Open source vs Enterprise
          yield "#{prefix}/open_source_vs_enterprise.html",
            "/walkthroughs/deploy/open_source_vs_enterprise.html",
            locals: locals

          PASSENGER_EDITIONS.each do |edition_spec|
            edition_type = edition_spec[:edition_type]
            prefix = "/walkthroughs/deploy/#{language_type}/#{infrastructure_type}/#{integration_mode_type}/#{edition_type}"
            locals = lang_spec.merge(infra_spec).merge(integration_mode_spec).merge(edition_spec)

            if needs_launch_server?(locals)
              # Launch a server
              yield "#{prefix}/launch_server.html",
                "/walkthroughs/deploy/launch_server.html",
                locals: locals
            end

            if needs_install_language_runtime?(locals)
              # Install language runtime
              yield "#{prefix}/install_language_runtime.html",
                "/walkthroughs/deploy/install_language_runtime.html",
                locals: locals
            end

            if needs_install_passenger?(locals)
              # Install Passenger: menu
              yield "#{prefix}/install_passenger_main.html",
                "/walkthroughs/deploy/install_passenger_main.html",
                locals: locals

              available_os_configs(locals).each do |os_config_spec|
                os_config = os_config_spec[:os_config_type]

                # Install Passenger: specific OS configuration
                yield "#{prefix}/#{os_config}/install_passenger.html",
                  "/walkthroughs/deploy/install_passenger.html",
                  locals: locals.merge(os_config_spec)
              end
            end

            # Deploy app: menu
            yield "#{prefix}/deploy_app_main.html",
              "/walkthroughs/deploy/deploy_app_main.html",
              locals: locals

            if needs_install_passenger?(locals)
              available_os_configs(locals).each do |os_config_spec|
                os_config = os_config_spec[:os_config_type]

                # Deploy app: specific OS configuration
                yield "#{prefix}/#{os_config}/deploy_app.html",
                  "/walkthroughs/deploy/deploy_app.html",
                  locals: locals.merge(os_config_spec)
              end
            end

            # Conclusion
            yield "#{prefix}/conclusion.html",
              "/walkthroughs/deploy/conclusion.html",
              locals: locals
          end
        end
      end
    end
  end


  def infrastructure_supported?(locals)
    locals[:language_type] == :ruby || locals[:infrastructure_type] != :heroku
  end

  def available_infrastructures(locals)
    DEPLOYMENT_WALKTHROUGH_INFRASTRUCTURES.find_all do |infra_spec|
      infrastructure_supported?(locals.merge(infra_spec))
    end
  end

  def needs_launch_server?(locals)
    locals[:infrastructure_has_launch_instructions]
  end


  def available_integration_modes(locals)
    if !locals.has_key?(:infrastructure_type)
      nil
    elsif locals[:infrastructure_type] == :heroku
      [{ integration_mode_type: :standalone,
         integration_mode_name: "Standalone" }]
    else
      [{ integration_mode_type: :nginx,
         integration_mode_name: "Nginx" },
       { integration_mode_type: :apache,
         integration_mode_name: "Apache" },
       { integration_mode_type: :standalone,
         integration_mode_name: "Standalone" }]
    end
  end

  def needs_pick_integration_mode?(locals)
    if !locals.has_key?(:infrastructure_type)
      nil
    else
      available_integration_modes(locals).size > 1
    end
  end

  def needs_install_passenger?(locals)
    if locals.has_key?(:integration_mode_type)
      locals[:language_type] != :ruby || locals[:integration_mode_type] != :standalone
    else
      nil
    end
  end


  def needs_install_language_runtime?(locals)
    if locals[:infrastructure_needs_install_language_runtime] == false # and not nil
      false
    else
      language_type = locals[:language_type]
      spec = DEPLOYMENT_WALKTHROUGH_LANGUAGES.find { |spec| spec[:language_type] == language_type }
      spec[:language_has_install_instructions]
    end
  end


  # Be sure to also update guides/install/shared/_os_selector.html.erb
  def available_os_configs(locals)
    result = [
      { os_config_type: :tarball,
        os_config_class: :tarball,
        os_config_name: "source tarball",
        os_config_description: "generic installation through source tarball" }
    ]
    if locals[:language_type] == :ruby
      result << {
        os_config_type: :rubygems_rvm,
        os_config_class: :rubygems,
        os_config_name: "RubyGems (with RVM)",
        os_config_description: "generic installation through RubyGems (with RVM)"
      }
      result << {
        os_config_type: :rubygems_norvm,
        os_config_class: :rubygems,
        os_config_name: "RubyGems (without RVM)",
        os_config_description: "generic installation through RubyGems (without RVM)"
      }
    end
    if locals[:edition_type] != :enterprise
      # Passenger Enterprise cannot be installed via Homebrew
      result << {
        os_config_type: :osx,
        os_config_class: :osx,
        os_config_name: "Mac OS X",
        os_config_description: "Mac OS X"
      }
    end
    SUPPORTED_DEBIAN_VERSIONS.each_pair do |codename, name|
      result << {
        os_config_type: codename.to_sym,
        os_config_class: :debian,
        os_config_name: name,
        os_config_description: name
      }
    end
    SUPPORTED_REDHAT_VERSIONS.each_pair do |distro_class, name|
      result << {
        os_config_type: distro_class.to_sym,
        os_config_class: :redhat,
        os_config_name: name,
        os_config_description: name
      }
    end
    result
  end


  def deployment_walkthrough_next_step_after_selecting_infrastructure(locals)
    if locals[:infrastructure_type] || available_infrastructures(locals).size == 1
      language_type = locals[:language_type]
      infrastructure_type = locals[:infrastructure_type] || available_infrastructures(locals)[0][:infrastructure_type]
      if available_integration_modes(locals).size == 1
        integration_mode_type = available_integration_modes(locals)[0][:integration_mode_type]
        { url: url_for("/walkthroughs/deploy/#{language_type}/#{infrastructure_type}/#{integration_mode_type}/open_source_vs_enterprise.html"),
          title: "Open source vs Enterprise",
          long_title: "Open source vs Enterprise",
          subsection: :open_source_vs_enterprise }
      else
        { url: url_for("/walkthroughs/deploy/#{language_type}/#{infrastructure_type}/integration_mode.html"),
          title: "Pick integration mode",
          long_title: "Pick an integration mode",
          subsection: :integration_mode }
      end
    else
      nil
    end
  end

  def deployment_walkthrough_next_step_after_selecting_passenger_edition(locals)
    language_type = locals[:language_type]
    infrastructure_type = locals[:infrastructure_type]
    integration_mode_type = locals[:integration_mode_type]
    edition_type = locals[:edition_type]
    if needs_launch_server?(locals)
      { url: url_for("/walkthroughs/deploy/#{language_type}/#{infrastructure_type}/#{integration_mode_type}/#{edition_type}/launch_server.html"),
        title: "Launch a server",
        long_title: "Launching a server",
        subsection: :launch_server }
    else
      deployment_walkthrough_next_step_after_launching_server(locals)
    end
  end

  def deployment_walkthrough_next_step_after_launching_server(locals)
    language_type = locals[:language_type]
    infrastructure_type = locals[:infrastructure_type]
    integration_mode_type = locals[:integration_mode_type]
    edition_type = locals[:edition_type]
    if needs_install_language_runtime?(locals)
      language_name = locals[:language_name]
      { url: url_for("/walkthroughs/deploy/#{language_type}/#{infrastructure_type}/#{integration_mode_type}/#{edition_type}/install_language_runtime.html"),
        title: "Install #{language_name}",
        long_title: "Installing #{language_name}",
        subsection: :install_language_runtime }
    else
      deployment_walkthrough_next_step_after_install_language_runtime(locals)
    end
  end

  def deployment_walkthrough_next_step_after_install_language_runtime(locals)
    language_type = locals[:language_type]
    infrastructure_type = locals[:infrastructure_type]
    integration_mode_type = locals[:integration_mode_type]
    edition_type = locals[:edition_type]
    if language_type == :ruby && integration_mode_type == :standalone
      { url: url_for("/walkthroughs/deploy/ruby/#{infrastructure_type}/standalone/#{edition_type}/deploy_app_main.html"),
        title: "Deploying the app",
        long_title: "Deploying the application",
        subsection: :deploy_app }
    else
      { url: url_for("/walkthroughs/deploy/#{language_type}/#{infrastructure_type}/#{integration_mode_type}/#{edition_type}/install_passenger_main.html"),
        title: "Install Passenger",
        long_title: "Installing Passenger on the production server",
        subsection: :install_passenger }
    end
  end
end
