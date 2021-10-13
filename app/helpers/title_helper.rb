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

  def current_user_avatar_url
    gravatar_id = Digest::MD5::hexdigest(current_user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png"
  end
end
