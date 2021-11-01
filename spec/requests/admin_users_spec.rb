require "rails_helper"

RSpec.describe "/admin/admin_users", type: :request do
  before(:each) { sign_in create(:user, role: :admin) }

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new admin user" do
        expect do
          post admin_admin_users_path, params: {user: attributes_for(:user)}
        end.to change(User.where(role: :admin), :count).by(1)
      end

      it "redirects to the created admin user" do
        post admin_admin_users_url, params: {user: attributes_for(:user)}
        expect(response).to redirect_to(admin_admin_users_url)
      end
    end
  end

  describe "PATCH #update" do
    context "with invalid parameters" do
      it "renders a successful response" do
        admin_user = User.create!(attributes_for(:user))
        patch admin_admin_user_url(admin_user), params: {user: attributes_for(:user, email: "")}
        expect(response).to be_successful
      end
    end
  end
end
