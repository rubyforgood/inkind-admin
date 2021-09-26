class Admin::SurveysController < ApplicationController
  before_action :set_admin_survey, only: [:show, :edit, :update, :destroy]

  # GET /admin/surveys
  def index
    @admin_surveys = Admin::Survey.all
  end

  # GET /admin/surveys/1
  def show
  end

  # GET /admin/surveys/new
  def new
    @admin_survey = Admin::Survey.new
  end

  # GET /admin/surveys/1/edit
  def edit
  end

  # POST /admin/surveys
  def create
    @admin_survey = Admin::Survey.new(admin_survey_params)

    if @admin_survey.save
      redirect_to @admin_survey, notice: 'Survey was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/surveys/1
  def update
    if @admin_survey.update(admin_survey_params)
      redirect_to @admin_survey, notice: 'Survey was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/surveys/1
  def destroy
    @admin_survey.destroy
    redirect_to admin_surveys_url, notice: 'Survey was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_survey
      @admin_survey = Admin::Survey.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_survey_params
      params.fetch(:admin_survey, {})
    end
end
