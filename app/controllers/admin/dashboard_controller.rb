module Admin
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :verify_admin?

    # GET /admin/dashboard
    def home; end

    private

    # Must be an admin to access dashboard
    def verify_admin?
      return if current_user.admin?

      flash[:alert] = "Sorry, only admins allowed to view the dashboard."
      redirect_to :root
    end

    # Only allow a list of trusted parameters through.
    def admin_dashboard_params
      params.fetch(:admin_dashboard, {})
    end
  end
end
