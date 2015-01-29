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

  def current_page_github_url
    path = current_page.path.sub(/\/$/, '')
    if path.include?("/")
      dir = path.sub(/(.*)\/.*/, '\1') + "/"
    else
      dir = ""
    end
    name = current_page.source_file.sub(/.*[\/\\]/, '')
    "https://github.com/phusion/passenger/edit/master/doc/#{dir}#{name}"
  end
end
