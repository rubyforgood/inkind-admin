class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin?

  # GET /admin/dashboard
  def home
  end

  private
    # Must be an admin to access dashboard
    def verify_admin?
      if !current_user.admin?
        flash[:alert] = "Sorry, only admins allowed to view the dashboard."
        redirect_to :root
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_admin_dashboard
      @admin_dashboard = Admin::Dashboard.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_dashboard_params
      params.fetch(:admin_dashboard, {})
    end
end
