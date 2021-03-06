module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Trailblazer App'
    if page_title.empty?
      base_title
    else
      "#{page_title}" | "#{base_title}"
    end
  end

  def date_format(date, format)
    date.strftime(format)
  end
end
