require "rails_helper"

module Mutations
  RSpec.describe UpdateUser, type: :request do
    describe ".resolve" do
      def query
        <<~GQL
          mutation($data: UpdateUserInput!) {
            user: updateUser(data: $data) {
              id
              firstName
              lastName
              phoneNumber
              email
            }
          }
        GQL
      end

      it "updates a user", :aggregate_failures do
        user = create(
          :user,
          first_name: "John",
          last_name: "Smith",
          phone_number: "000-000-0000",
          email: "john@smith.com",
          password: "[redacted]",
          password_confirmation: "[redacted]"
        )

        post "/graphql",
          params: {
            query: query,
            variables: {
              data: {
                firstName: "Violet",
                lastName: "Volunteer",
                phoneNumber: "111-222-3333",
                email: "violet@volunteer.com"
              }
            }
          },
          headers: {
            "Authorization" => "Bearer #{user.token}"
          }

        json = JSON.parse(response.body)
        expect(json["errors"]).to be_nil

        user_data = json["data"]["user"]
        expect(user_data["id"]).to eq user.id.to_s
        expect(user_data["firstName"]).to eq "Violet"
        expect(user_data["lastName"]).to eq "Volunteer"
        expect(user_data["phoneNumber"]).to eq "111-222-3333"
        expect(user_data["email"]).to eq "violet@volunteer.com"

        expect(User.first.first_name).to eq "Violet"
      end
    end
  end
end
