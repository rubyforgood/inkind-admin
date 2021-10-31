require "rails_helper"

module Queries
  RSpec.describe "query students", type: :request do
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

    describe ".resolve" do
      let(:volunteer) { create(:volunteer) }
      let!(:student) { create(:student) }
      let!(:other_student) { create(:student) }
      let!(:inactive_student) { create(:student, status: :inactive) }

      before do
        create(:student_volunteer_assignment, student: student, volunteer: volunteer)
        create(:student_volunteer_assignment, student: inactive_student, volunteer: volunteer)
      end

      context "when signed in" do
        before { sign_in(volunteer) }

        it "returns active students belonging to volunteer", :aggregate_failures do
          post "/graphql", params: {query: query}

          expect(response).to be_successful

          json = JSON.parse(response.body)
          data = json["data"]["students"]

          expect(data.size).to eq(1)
          expect(data[0]).to_not be_nil
          expect(data[0]["id"]).to eq(student.id.to_s)

          ids = data.pluck("id")
          expect(ids).to include(student.id.to_s)
          expect(ids).to_not include(other_student.id.to_s)
          expect(ids).to_not include(inactive_student.id.to_s)
        end
      end

      it "returns nothing when not signed in", :aggregate_failures do
        post "/graphql", params: {query: query}
        expect(response).to be_successful

        json = JSON.parse(response.body)
        data = json["data"]["students"]

        expect(data).to be_nil
      end
    end
  end
end
