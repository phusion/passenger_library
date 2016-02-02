require_relative 'constants'

SUPPORTED_DEBIAN_VERSIONS = {
  "jessie"  => "Debian 8",
  "wheezy"  => "Debian 7",
  "wily"    => "Ubuntu 15.10",
  "trusty"  => "Ubuntu 14.04 LTS",
  "precise" => "Ubuntu 12.04 LTS"
}

SUPPORTED_REDHAT_VERSIONS = {
  "el7" => "Red Hat 7 / CentOS 7",
  "el6" => "Red Hat 6 / CentOS 6"
}

module CustomHelpers
  def globals
    @globals ||= {}
  end

  def h2(id_prefix, title)
    "<h2 id=\"#{id_prefix}#{slug(title)}\">#{title}</h2>"
  end

  def h3(id_prefix, title)
    "<h3 id=\"#{id_prefix}#{slug(title)}\">#{title}</h3>"
  end

  def slug(title)
    title.sub(/^[0-9]+(\.[0-9])*/, "").scan(/[a-z0-9]+/i).join("-").downcase
  end

  def site_title
    if config[:display_guides]
      "Passenger Library"
    else
      "Passenger Walkthroughs"
    end
  end

  def page_title
    current_page.data.title || @page_title
  end

  def navbar_section(id)
    if current_page.data.section == id.to_s
      concat("<li class=\"active\">")
    else
      concat("<li>")
    end
    yield
    concat("</li>")
  end

  def navbar_dropdown_section(*ids)
    ids = ids.map { |x| x.to_s }
    if ids.include?(current_page.data.section)
      concat("<li class=\"active dropdown\">")
    else
      concat("<li class=\"dropdown\">")
    end
    yield
    concat("</li>")
  end

  def navbar_subsection(id)
    if current_page.data.subsection == id.to_s
      concat("<li class=\"active\">")
    else
      concat("<li>")
    end
    yield
    concat("</li>")
  end

  def current_page_github_url
    path = current_page.source_file.sub(/.*source\//, '')
    "https://github.com/phusion/passenger_library/edit/master/source/#{path}"
  end

  def has_sidebar?
    content_for?(:sidebar) || current_page.data.sidebar
  end

  def yield_sidebar_content
    if content_for?(:sidebar)
      yield_content(:sidebar)
    else
      render_partial(current_page.data.sidebar)
    end
  end

  def append_to_layout_body(&block)
    globals[:layout_body_trailer] ||= ""
    globals[:layout_body_trailer] << capture_html(&block)
  end

  def absolute_url_for(path, options = {})
    config[:url_root] + url_for(path, options.merge(relative: false))
  end

  def comments_section_classes
    if has_sidebar?
      "col-md-8 col-md-offset-3"
    else
      "col-md-8 col-md-offset-2"
    end
  end

  def should_use_bundle_exec_for_passenger?(locals)
    (locals[:language_type] == :ruby || current_page.data.language_type == 'ruby') &&
      (current_page.data.section == "start" ||
       current_page.data.section == "basics" ||
       locals[:integration_mode_type] == :standalone)
  end

  def passenger_command_prefix(locals)
    if should_use_bundle_exec_for_passenger?(locals)
      "bundle exec "
    else
      ""
    end
  end

  def passenger_command_prefix_html(locals, options = {})
    if locals[:language_type] == :ruby || current_page.data.language_type == 'ruby'
      result = ""
      if options.fetch(:cd, true)
        result << %Q{<span class="prompt">$ </span>cd /path-to-your-app\n}
      end
      if should_use_bundle_exec_for_passenger?(locals)
        result << %Q{<span class="prompt">$ </span>bundle exec }
      else
        %Q{<span class="prompt">$ </span>}
      end
    else
      %Q{<span class="prompt">$ </span>}
    end
  end

  def debian_version_selection_options
    result = ""
    maybe_selected = " selected"
    SUPPORTED_DEBIAN_VERSIONS.each_pair do |codename, name|
      stylized_codename = codename.dup
      stylized_codename[0..0] = stylized_codename[0..0].upcase
      result << %Q{<option value="#{codename}"#{maybe_selected}>#{name} (#{stylized_codename})</option>}
      maybe_selected = nil
    end
    result
  end

  def debian_version_list_options(next_page)
    result = ""
    SUPPORTED_DEBIAN_VERSIONS.each_pair do |codename, name|
      stylized_codename = codename.dup
      stylized_codename[0..0] = stylized_codename[0..0].upcase
      result << %Q{<li><a href="#{codename}/#{next_page}">#{name} (#{stylized_codename})</a></li>}
    end
    result
  end

  def redhat_version_selection_options
    result = ""
    maybe_selected = " selected"
    SUPPORTED_REDHAT_VERSIONS.each_pair do |version, name|
      result << %Q{<option value="#{version}"#{maybe_selected}>#{name}</option>}
      maybe_selected = nil
    end
    result
  end

  def redhat_version_list_options(next_page)
    result = ""
    SUPPORTED_REDHAT_VERSIONS.each_pair do |version, name|
      result << %Q{<li><a href="#{version}/#{next_page}">#{name}</a></li>}
    end
    result
  end

  def current_page_path
    path = "#{config[:url_root]}/#{current_page.path}"
    path.sub(/\/index\.html$/, "/")
  end

  def current_url_generalized(generalized_param, scan_for)
    regex_str = ""
    scan_for.each_with_index do |entry, idx|
      regex_str << "|" if idx > 0
      regex_str << "/" + entry + "/"
    end
    regex = /(#{regex_str})/
    path = current_page_path.gsub(regex, "/" + generalized_param + "/")
  end

  def current_url_with_other_integration_mode(other_integration_mode, available_integration_modes, section_path)
    available = false
    available_integration_modes.each do |spec|
      if spec[:integration_mode_type] == other_integration_mode
        available = true
        break
      end
    end

    if available
      path = current_page_path
    else
      path = section_path
    end
    path.gsub(/(nginx|apache|standalone)/, other_integration_mode.to_s)
  end

  def current_url_with_other_edition(other_edition, available_editions, section_path)
    available = false
    available_editions.each do |spec|
      if spec[:edition_type] == other_edition
        available = true
        break
      end
    end

    if available
      path = current_page_path
    else
      path = section_path
    end
    path.gsub(/(oss|enterprise)/, other_edition.to_s)
  end

  def current_url_prefix_without_programming_language
    language_types = []
    SUPPORTED_LANGUAGES.each do |spec|
      language_types << spec[:language_type]
    end
    current_page_path =~ /(.*)(#{language_types.join("|")})(.*)/
    $1
  end

  def current_url_suffix_without_programming_language
    language_types = []
    SUPPORTED_LANGUAGES.each do |spec|
      language_types << spec[:language_type]
    end
    current_page_path =~ /(.*)(#{language_types.join("|")})(.*)/
    $3
  end

  def link_to_config_option(name, locals)
    %Q{<a href="#{url_for_config_option(name, locals)}">#{resolve_config_option_name(name, locals)}</a>}
  end

  # Given a config option name such as `max_pool_size`, transforms it into a form
  # that that is suitable for the current integration mode.
  def resolve_config_option_name(name, locals)
    name = resolve_config_option_alias(name, locals)
    case locals[:integration_mode_type]
    when :nginx
      "passenger_#{name}"
    when :apache
      new_name = name.to_s.gsub(/_([a-z])/) { |match| match.sub('_', '').upcase }
      new_name[0] = new_name[0].upcase
      "Passenger#{new_name}"
    when :standalone
      cli_option = "--" + name.to_s.gsub('_', '-')
      "<code>#{h cli_option}</code> / \"#{h name}\""
    when nil
      name.to_s.gsub('_', ' ')
    else
      raise "Unknown itegration mode #{locals[:integration_mode_type]}"
    end
  end

  # Given a config option name such as `max_pool_size`, returns the corresponding
  # integration mode-specific URL for its reference.
  def url_for_config_option(name, locals)
    name = resolve_config_option_alias(name, locals)
    case locals[:integration_mode_type]
    when :nginx
      url_for("/config/nginx/reference/index.html") + "#passenger_#{name}"
    when :apache
      anchor = name.to_s.gsub(/_/, '').downcase
      url_for("/config/apache/reference/index.html") + "#passenger#{anchor}"
    when :standalone
      cli_option = "--" + name.to_s.gsub('_', '-')
      anchor = "#{cli_option}-#{name}"
      url_for("/config/standalone/reference/index.html") + "##{anchor}"
    when nil
      url_for("/config/reference/index.html") + "?a=passenger_#{name}"
    else
      raise "Unknown itegration mode #{locals[:integration_mode_type]}"
    end
  end

  def resolve_config_option_alias(name, locals)
    if locals[:integration_mode_type] == :standalone && name == :max_instances
      :max_pool_size
    else
      name
    end
  end

  def is_choice_filtered?(choice, limit_choices)
    return false if limit_choices.nil?

    limit_choices.each do |limit_choice|
      return false if choice[:val].eql? limit_choice[:choice_val]
    end
    return true
  end

  def get_choices_as_jsarray(limit_choices)
    return "[]" if limit_choices.nil?
    jsarray = "['"
    limit_choices.each_with_index do |limit_choice, idx|
      jsarray << "', '" if idx > 0
      jsarray << limit_choice[:choice_val]
    end
    jsarray << "']"
    return jsarray
  end
end
