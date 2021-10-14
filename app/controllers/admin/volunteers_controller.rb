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
      @volunteer = User.new(volunteer_params)
      @volunteer.skip_password_validation = true

      if @volunteer.valid?
        @volunteer.save!
        redirect_to admin_volunteers_url, notice: "Volunteer was successfully created."
      else
        flash[:alert] = format_errors(@volunteer)
        render :new
      end
    end

    def update
      @volunteer = User.find(params[:id])
      if @volunteer.update(volunteer_params)
        redirect_to admin_volunteers_url, notice: "Volunteer was successfully updated."
      else
        flash[:alert] = format_errors(@volunteer)
        render :edit
      end
    end

    def activate
      @volunteer = User.find(params[:id])
      @volunteer.deactivated_at = nil
      @volunteer.deactivator_id = nil
      @volunteer.status = :active
      @volunteer.save!

      redirect_to admin_volunteers_url, alert: "Volunteer was successfully activated."
    end

    def deactivate
      @volunteer = User.find(params[:id])
      @volunteer.deactivated_at = Time.now
      @volunteer.deactivator_id = current_user.id
      @volunteer.status = :inactive
      @volunteer.save!

      redirect_to admin_volunteers_url, alert: "Volunteer was successfully deactivated."
    end

    def volunteer_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone_number)
    end
  end
end
