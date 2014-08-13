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
  
  def status_message(subscription)
    if subscription.status == "Trial"
      content_tag(:div, class: "well well-lg") do
        content_tag(:h1, trial_message(subscription), class: "text-center") +
        content_tag(:p,"We hope you’ve enjoyed using Basecamp so far. While you don’t have to do it right now, you’ll want to be sure to set up your subscription below before your trial is up to prevent any disruption in service.", class: "text-center")
      end
    end
  end
  
  def trial_message(subscription)
    days = days_remaining(subscription.free_trial_expiration)
    "You have #{pluralize(days, 'day')} left on your free trial."
  end
  
  def days_remaining(end_date)
    (end_date - Time.zone.now.to_date).to_i
  end
  
end
