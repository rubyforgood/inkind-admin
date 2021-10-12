module Admin
  class VolunteersController < ApplicationController

    def index
      @volunteers = User.where(role: :volunteer)
    end

    def new
      @volunteer = User.new
    end

    def edit
      @volunteer = User.find(params[:id])
    end

    def create
      user = User.new(volunteer_params)
      user.skip_password_validation = true
      user.volunteer!
      user.active!

      if user.save!
        redirect_to admin_volunteers_url, notice: "Volunteer was successfully created."
      else
        render :new
      end
    end

    def update
      @volunteer = User.find(params[:id])
      if @volunteer.update(volunteer_params)
        redirect_to admin_volunteers_url, notice: "Volunteer was successfully updated."
      else
        render :edit
      end
    end

    def volunteer_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone_number)
    end
  end
end
