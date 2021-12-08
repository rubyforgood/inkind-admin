require "rails_helper"

RSpec.describe "/", type: :request do
  context "unauthenticated" do
    it "renders the admin template" do
      get root_url

      expect(response).to redirect_to "/users/sign_in"
    end
  end

  context "as an admin" do
    before { sign_in create(:user, role: :admin) }

    it "renders the admin template" do
      get root_url

      expect(response).to be_successful
      expect(response.body).to include "Home"
    end
  end

  context "as a volunteer" do
    before { sign_in create(:user, role: :volunteer) }

    it "renders the admin template" do
      get root_url

      expect(response).to be_successful
      expect(response.body).to include "Volunteer Home"
    end
  end
end
