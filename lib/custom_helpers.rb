require_relative 'constants'

CURRENT_VERSION = "5.0.0"
LATEST_RUBY_VERSION = "2.2.1"

SUPPORTED_DEBIAN_VERSIONS = {
  "jessie"  => "Debian 8",
  "wheezy"  => "Debian 7",
  "squeeze" => "Debian 6",
  "vivid"   => "Ubuntu 15.04",
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
end
