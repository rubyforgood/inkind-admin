module Admin
  class VolunteersController < ApplicationController
    # GET /admin/dashboard
    def index
      @volunteers = User.where(role: :volunteer)
    end
  end
end
