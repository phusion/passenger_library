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
end
