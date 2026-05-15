module ApplicationHelper
  def currency(value)
    number_to_currency(value || 0, unit: "R$ ", separator: ",", delimiter: ".")
  end

  def status_badge(status)
    content_tag(:span, status.to_s.humanize, class: "badge badge-#{status}")
  end
end
