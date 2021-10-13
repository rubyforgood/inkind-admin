module TitleHelper
  def page_title
    [
      page_header_title,
      default_title,
    ].compact.join(" | ")
  end

  def page_header_title
    content_for(:title)
  end

  def default_title
    t(:title)
  end
end
