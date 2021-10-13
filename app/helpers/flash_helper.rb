module FlashHelper
  CSS_CLASS = {
    notice: "alert-info",
    success: "alert-success",
    error: "alert-danger",
    alert: "alert-warning"
  }
  def flash_banner(level, message)
    return unless message

    content_tag(:div, message, class: ["alert", level, CSS_CLASS[level]].uniq)
  end
end
