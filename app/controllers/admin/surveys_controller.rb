module Admin
  class SurveysController < ApplicationController
    def index
      @nav = "Surveys"
      @surveys = Survey.all
    end
  end
end
