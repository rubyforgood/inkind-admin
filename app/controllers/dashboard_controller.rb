class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.admin?
      render :admin
    else
      render :volunteer
    end
  end
end
