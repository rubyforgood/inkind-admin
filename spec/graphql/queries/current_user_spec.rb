# frozen_string_literal: true

require 'rails_helper'

module Queries
  RSpec.describe 'query current_user', type: :request do
    def query
      <<~GQL
        query {
          currentUser {
            id
            email
            name
            role
          }
        }
      GQL
    end

    describe '.resolve' do
      let(:user) { create(:user) }
      let(:valid_response) do
        JSON.parse(
          JSON.generate(
            {
              id: user.id.to_s,
              email: user.email,
              name: user.name,
              role: user.role.to_s
            }
          )
        )
      end

      context 'when signed in' do
        before { sign_in(user) }

        it 'returns current user', :aggregate_failures do
          post '/graphql', params: { query: query }

          expect(response).to be_successful

          json = JSON.parse(response.body)
          data = json['data']['currentUser']

          expect(data).to include(valid_response)
        end
      end

      it 'returns nothing when not signed in', :aggregate_failures do
        post '/graphql', params: { query: query }

        expect(response).to be_successful

        json = JSON.parse(response.body)
        data = json['data']['currentUser']

        expect(data).to be_nil
      end
    end
  end
end
