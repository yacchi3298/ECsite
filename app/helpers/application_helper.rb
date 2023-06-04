module ApplicationHelper
  def full_title(page_title)
    page_title.blank? ? Const::BASE_TITLE : "#{page_title} - #{Const::BASE_TITLE}"
  end
end
