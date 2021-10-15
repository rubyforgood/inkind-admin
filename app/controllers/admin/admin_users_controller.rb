module Admin
  class AdminUsersController < ApplicationController
    def index
      @admin_users = User.where(role: :admin)
    end

    def new
      @admin_user = User.new
    end

    def edit
      @admin_user = User.where(role: :admin).find(params[:id])
    end

    def create
      @admin_user = User.new(admin_user_params)
      @admin_user.skip_password_validation = true

      if @admin_user.valid?
        @admin_user.save!
        redirect_to admin_admin_users_url, notice: "Admin was successfully created."
      else
        flash[:alert] = format_errors(@admin_user)
        render :new
      end
    end

    def update
      @admin_user = User.find(params[:id])
      if @admin_user.update(admin_user_params)
        redirect_to admin_admin_users_url, notice: "Admin was successfully updated."
      else
        flash[:alert] = format_errors(@admin_user)
        render :edit
      end
    end

    def activate
      @admin_user = User.where(role: :admin).find(params[:id])
      @admin_user.activate!

      redirect_to admin_admin_users_url, notice: "Admin was successfully activated."
    end

    def deactivate
      @admin_user = User.where(role: :admin).find(params[:id])

      if current_user == @admin_user
        redirect_to admin_admin_users_url, alert: "You can not deactivate your own account."
      else
        @admin_user.deactivate!(deactivator_id: current_user.id)

        redirect_to admin_admin_users_url, notice: "Admin was successfully deactivated."
      end
    end

    def admin_user_params
      params.require(:user)
        .permit(:first_name, :last_name, :email, :phone_number)
        .merge(role: :admin)
    end
  end
end
