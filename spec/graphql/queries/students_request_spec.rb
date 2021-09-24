require 'rails_helper'

module Queries
  RSpec.describe 'query students', type: :request do
    def query
      <<~GQL
        query {
          students {
            id
            email
          }
        }
      GQL
    end

    describe '.resolve' do
      let!(:student) { create(:student) }

      it 'returns all studens' do
        post '/graphql', params: { query: query }

        expect(response).to be_successful

        json = JSON.parse(response.body)
        data = json['data']['students']

        expect(data[0]).to_not be_nil
        expect(data[0]['id']).to eq(student.id.to_s)
      end

      # it 'returns nothing when not signed in' do
      #   post '/graphql', params: { query: query }
      #   expect(response).to be_successful

      #   json = JSON.parse(response.body)
      #   data = json['data']['currentUser']

      #   expect(data).to be_nil
      # end
    end
  end
end
