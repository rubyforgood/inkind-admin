require "rails_helper"

RSpec.describe "/admin/admin_users", type: :request do
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
      it "creates a new admin user" do
        expect do
          post admin_admin_users_path, params: {user: valid_attributes}
        end.to change(User.where(role: :admin), :count).by(1)
      end

      it "redirects to the created admin user" do
        post admin_admin_users_url, params: {user: valid_attributes}
        expect(response).to redirect_to(admin_admin_users_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new admin user" do
        expect do
          post admin_admin_users_url, params: {user: invalid_attributes}
        end.to change(User.where(role: :admin), :count).by(0)
      end

      it "renders a successful response" do
        post admin_admin_users_url, params: {user: invalid_attributes}
        expect(response).to be_successful
      end
    end

    context "with invalid parameters" do
      it "renders a successful response" do
        admin_user = User.create! valid_attributes
        patch admin_admin_user_url(admin_user), params: {user: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end
end