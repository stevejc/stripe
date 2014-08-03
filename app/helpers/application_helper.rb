module ApplicationHelper
  
  def page_title(title)
    title == "" ? "Multi" : title
  end
  
  def flash_class(type)
    case type
    when :alert
      "alert-danger"
    when :notice
      "alert-success"
    else
      ""
    end
  end
  
end
