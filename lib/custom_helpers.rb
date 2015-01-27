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

  def current_page_github_url
    dir = current_page.path.sub(/(.*)\/.*/, '\1')
    name = current_page.source_file.sub(/.*[\/\\]/, '')
    "https://github.com/phusion/passenger/doc/#{dir}/#{name}"
  end
end
