module Admin
  class SurveysController < ApplicationController
    def index
      @nav = "Surveys"
      @total_surveys = Survey.all
      @pagy, @surveys = pagy(@total_surveys)
    end
  end
end
