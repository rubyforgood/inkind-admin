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
      let(:user) { create(:user) }
      let(:student) { create(:student) }
      let!(:other_student) { create(:student) }

      before { user.students << student }

      context 'when signed in' do
        before { sign_in(user) }

        it 'returns all students belonging to user' do
          post '/graphql', params: { query: query }

          expect(response).to be_successful

          json = JSON.parse(response.body)
          data = json['data']['students']

          expect(data.size).to eq(1)
          expect(data[0]).to_not be_nil
          expect(data[0]['id']).to eq(student.id.to_s)

          ids = data.pluck('id')
          expect(ids).to include(student.id.to_s)
          expect(ids).to_not include(other_student.id.to_s)
        end
      end

      it 'returns nothing when not signed in' do
        post '/graphql', params: { query: query }
        expect(response).to be_successful

        json = JSON.parse(response.body)
        data = json['data']['students']

        expect(data).to be_nil
      end
    end
  end
end
