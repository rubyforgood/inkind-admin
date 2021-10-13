require "rails_helper"

RSpec.describe "/admin/volunteers", type: :request do
  before(:each) do
    sign_in create(:user, role: :admin)
  end

  let(:valid_attributes) do
    attributes_for(:user)
  end

  let(:invalid_attributes) do
    attributes_for(:user, email: "")
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Volunteer" do
        expect do
          post admin_volunteers_path, params: {user: valid_attributes}
        end.to change(User, :count).by(1)
      end

      it "redirects to the created volunteer" do
        post admin_volunteers_url, params: {user: valid_attributes}
        expect(response).to redirect_to(admin_volunteers_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new volunteer" do
        expect do
          post admin_volunteers_url, params: {user: invalid_attributes}
        end.to change(User, :count).by(0)
      end

      it "renders a successful response" do
        post admin_volunteers_url, params: {user: invalid_attributes}
        expect(response).to be_successful
      end
    end

    context "with invalid parameters" do
      it "renders a successful response" do
        volunteer = User.create! valid_attributes
        patch admin_volunteer_url(volunteer), params: {user: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end
end
