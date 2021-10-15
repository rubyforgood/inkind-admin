require "rails_helper"

module Mutations
  RSpec.describe UpdateUserPassword, type: :request do
    describe ".resolve" do
      def query
        <<~GQL
          mutation($oldPassword: String!, $password: String!) {
            success: updateUserPassword(oldPassword: $oldPassword, password: $password)
          }
        GQL
      end

      it "updates the password", :aggregate_failures do
        user = create(:user, password: "password")

        post "/graphql",
          params: {
            query: query,
            variables: {
              oldPassword: "password",
              password: "newPass"
            }
          },
          headers: {
            "Authorization" => "Bearer #{user.token}"
          }

        json = JSON.parse(response.body)
        expect(json["errors"]).to be_nil
        expect(json["data"]["success"]).to be_truthy
        expect(User.first.valid_password?("newPass")).to be_truthy
      end
    end
  end
end
