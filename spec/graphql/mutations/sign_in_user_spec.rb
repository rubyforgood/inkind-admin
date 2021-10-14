require "rails_helper"

module Mutations
  RSpec.describe SignInUser, type: :request do
    let!(:user) { create(:user, email: "email@example.com", password: "[redacted]", password_confirmation: "[redacted]") }

    describe ".resolve" do
      def query
        <<~GQL
          mutation($credentials: AuthProviderCredentialsInput!) {
            signInUser(
              credentials: $credentials
            ) {
              user {
                name
                email
              }
              token
            }
          }
        GQL
      end

      it "creates a user token", :aggregate_failures do
        post "/graphql",
          params: {
            query: query,
            variables: {
              credentials: {
                email: "email@example.com",
                password: "[redacted]"
              }
            }
          }
        json = JSON.parse(response.body)
        data = json["data"]["signInUser"]

        expect(data).to have_key("user")
        expect(data).to have_key("token")
      end

      it "does not create a session if user account is not active", :aggregate_failures do
        user.inactive!

        post "/graphql",
          params: {
            query: query,
            variables: {
              credentials: {
                email: "email@example.com",
                password: "[redacted]"
              }
            }
          }
        json = JSON.parse(response.body)

        expect(json.dig("data", "signInUser")).to be_nil
        expect(json.dig("errors", 0, "message")).to eq("account associated with email is no longer active")
      end
    end
  end
end
