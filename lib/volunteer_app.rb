module VolunteerApp
module_function

  def magic_link(user)
    uri = URI(Rails.application.config.volunteer_app_url)
    uri.query = "token=#{CGI.escape(user.token)}"
    uri.to_s
  end
end
