module Admin
  class ApplicationController < ::ApplicationController
    before_action :verify_admin?

    private

    # Must be an admin to access admin views
    def verify_admin?
      return if current_user.admin?

      flash[:alert] = "Sorry, only admins can view this page."
      redirect_to :root
    end
  end
end
