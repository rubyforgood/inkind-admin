require "rails_helper"

module Mutations
  RSpec.describe SignInUser, type: :request do
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

      it "creates a session" do
        create(
          :user,
          email: "email@example.com",
          password: "[redacted]",
          password_confirmation: "[redacted]"
        )

        post "/graphql",
             params: {
               query: query,
               variables: {
                 credentials: {
                   email: "email@example.com",
                   password: "[redacted]",
                 },
               },
             }
        json = JSON.parse(response.body)
        data = json["data"]["signInUser"]

        expect(data).to have_key("user")
        expect(data).to have_key("token")
      end
    end
  end
end
