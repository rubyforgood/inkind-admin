module Admin
  class ApplicationController < ::ApplicationController
    before_action :authenticate_user!, :verify_admin!

  private

    def verify_admin!
      verify_user! "Sorry, only admins can view this page.", &:admin?
    end
  end
end
