module Admin
  class VolunteersController < ApplicationController
    def index
      @nav = "Volunteers"
      @total_volunteers = User.where(role: :volunteer).order(:last_name)
      @pagy, @volunteers = pagy(@total_volunteers)

      session[:filters] = {volunteers_table: {}} unless @stimulus_reflex

      respond_to do |format|
        format.html
        format.csv do
          send_data(
            User.export_to_csv(@total_volunteers,
              columns: User::VOLUNTEER_EXPORT_COLUMNS,
              headers: User::VOLUNTEER_EXPORT_HEADERS),
            filename: "volunteers-#{Date.current}.csv"
          )
        end
      end
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
      @volunteer.activate!

      redirect_to admin_volunteers_url, alert: "Volunteer was successfully activated."
    end

    def deactivate
      @volunteer = User.find(params[:id])
      @volunteer.deactivate!(deactivator_id: current_user.id)

      redirect_to admin_volunteers_url, alert: "Volunteer was successfully deactivated."
    end

    def send_link
      volunteer = User.find(params[:id])

      MagicLinkMailer.sign_in(volunteer).deliver

      flash[:alert] = "Authentication link sent to #{volunteer.name}"
      redirect_to action: :index
    end

    private

    def volunteer_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone_number)
    end
  end
end
