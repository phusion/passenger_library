# Introduction, select infrastructure
# Select integration mode
# Open source vs Enterprise
# Install Passenger
# Deploying the app
# Automating deployments
# Conclusion
module DeploymentWalkthroughHelpers
  DEPLOYMENT_WALKTHROUGH_LANGUAGES = [
    { language_type: :ruby, language_name: "Ruby" },
    { language_type: :python, language_name: "Python" },
    { language_type: :nodejs, language_name: "Node.js" },
    { language_type: :iojs, language_name: "io.js" },
    { language_type: :meteor, language_name: "Meteor" }
  ]
  DEPLOYMENT_WALKTHROUGH_INFRASTRUCTURES = [
    { infrastructure_type: :heroku,
      infrastructure_name: "Heroku",
      infrastructure_long_name: "Heroku" },
    { infrastructure_type: :ownserver,
      infrastructure_name: "Linux/Unix",
      infrastructure_long_name: "Any hosting provider or infrastructure running Linux/Unix" }
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


  def available_integration_modes(locals)
    if locals[:infrastructure_type] == :heroku
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

  def needs_install_passenger?(integration_mode)
    integration_mode != :standalone
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
