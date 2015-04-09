CURRENT_VERSION = "5.0.0"

module CustomHelpers
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
    path = current_page.path.sub(/\/$/, '')
    if path.include?("/")
      dir = path.sub(/(.*)\/.*/, '\1') + "/"
    else
      dir = ""
    end
    name = current_page.source_file.sub(/.*[\/\\]/, '')
    "https://github.com/phusion/passenger_library/edit/master/source/#{dir}#{name}"
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
end
