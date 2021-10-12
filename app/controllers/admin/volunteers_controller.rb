module Admin
  class VolunteersController < ApplicationController
    # GET /admin/dashboard
    def index
      @volunteers = User.where(role: :volunteer)
    end

    def edit
      @volunteer = User.find(params[:id])
    end

    def update
      @volunteer = User.find(params[:id])
      if @volunteer.update(volunteer_params)
        redirect_to admin_volunteer_path(@volunteer), notice: "Volunteer was successfully updated."
      else
        render :edit
      end
    end

    def volunteer_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone_number)
    end
  end
end
