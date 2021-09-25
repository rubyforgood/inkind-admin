class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    if current_user.admin?
      :admin_dashboard
    elsif current_user.volunteer?
      :root
    else
      :root
    end
  end
end
