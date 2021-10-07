# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def after_sign_in_path_for(_resource)
    if current_user.admin?
      :admin_dashboard
    else
      :root
    end
  end
end
