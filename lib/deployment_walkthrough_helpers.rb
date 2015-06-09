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
      locals[:integration_mode_type] != :standalone
    else
      nil
    end
  end


  def needs_install_language_runtime?(locals)
    if !locals[:infrastructure_type]
      nil
    elsif locals[:infrastructure_needs_install_language_runtime]
      language_type = locals[:language_type]
      spec = DEPLOYMENT_WALKTHROUGH_LANGUAGES.find { |spec| spec[:language_type] == language_type }
      spec[:language_has_install_instructions]
    else
      false
    end
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
      { url: url_for("/walkthroughs/deploy/ruby/#{infrastructure_type}/standalone/#{edition_type}/deploy_app.html"),
        title: "Deploying the app",
        long_title: "Deploying the application",
        subsection: :deploy_app }
    else
      { url: url_for("/walkthroughs/deploy/#{language_type}/#{infrastructure_type}/#{integration_mode_type}/#{edition_type}/install_passenger.html"),
        title: "Install Passenger",
        long_title: "Installing Passenger on the production server",
        subsection: :install_passenger }
    end
  end
end
