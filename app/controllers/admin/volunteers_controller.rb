class Admin::VolunteersController < ApplicationController
  before_action :set_admin_volunteer, only: [:show, :edit, :update, :destroy]

  # GET /admin/volunteers
  def index
    @admin_volunteers = Admin::Volunteer.all
  end

  # GET /admin/volunteers/1
  def show
  end

  # GET /admin/volunteers/new
  def new
    @admin_volunteer = Admin::Volunteer.new
  end

  # GET /admin/volunteers/1/edit
  def edit
  end

  # POST /admin/volunteers
  def create
    @admin_volunteer = Admin::Volunteer.new(admin_volunteer_params)

    if @admin_volunteer.save
      redirect_to @admin_volunteer, notice: 'Volunteer was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/volunteers/1
  def update
    if @admin_volunteer.update(admin_volunteer_params)
      redirect_to @admin_volunteer, notice: 'Volunteer was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/volunteers/1
  def destroy
    @admin_volunteer.destroy
    redirect_to admin_volunteers_url, notice: 'Volunteer was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_volunteer
      @admin_volunteer = Admin::Volunteer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_volunteer_params
      params.fetch(:admin_volunteer, {})
    end
end
