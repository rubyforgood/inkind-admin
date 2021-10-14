require "rails_helper"

module Queries
  RSpec.describe "query survey_responses", type: :request do
    def query
      <<~GQL
        query {
          surveyResponses {
            student {
              name
            }
            volunteer {
              id
              name
            }
            meetingDuration {
              minutes
              startedAt
            }
          }
        }
      GQL
    end

    def student_query(student)
      <<~GQL
        query {
          studentSurveyResponses(id: #{student.id}) {
            student {
              name
            }
            volunteer {
              id
              name
            }
            meetingDuration {
              minutes
              startedAt
            }
          }
        }
      GQL
    end

    def create_response(volunteer, student, minutes, started_at)
      create(
        :survey_response,
        volunteer: volunteer,
        student: student,
        meeting_duration: create(:meeting_duration, minutes: minutes, started_at: started_at)
      )
    end

    describe "all surveys .resolve" do
      let(:volunteer) { create(:user, :volunteer) }

      before do
        adam = create(:student, first_name: "Adam", last_name: "Ruby")
        gia = create(:student, first_name: "Gia", last_name: "ForGood")
        travel_to(yesterday) do
          create_response(volunteer, adam, 42, Time.zone.now - 6.hours)
          create_response(volunteer, gia, 46, Time.zone.now - 4.hours)
        end
      end

      context "when signed in" do
        it "returns all survey_responses belonging to user", :aggregate_failures do
          sign_in(volunteer)

          post "/graphql", params: {query: query}

          expect(response).to be_successful

          json = JSON.parse(response.body)
          data = json["data"]["surveyResponses"]

          expect(data.size).to eq(2)
          expect(data[0]["volunteer"]["name"]).to eq(volunteer.name)
          expect(data[0]["volunteer"]["id"]).to eq(volunteer.id.to_s)
          expect(data[0]["student"]["name"]).to eq("Adam Ruby")
          expect(data[1]["student"]["name"]).to eq("Gia ForGood")

          expect(data[0]["meetingDuration"]["minutes"]).to eq(42)
          expect(parse_time(data[0]["meetingDuration"]["startedAt"])).to eq (yesterday - 6.hours).strftime("%F").to_s
          expect(data[1]["meetingDuration"]["minutes"]).to eq(46)
          expect(parse_time(data[1]["meetingDuration"]["startedAt"])).to eq (yesterday - 4.hours).strftime("%F").to_s
        end
      end

      it "returns nothing when not signed in", :aggregate_failures do
        post "/graphql", params: {query: query}
        expect(response).to be_successful

        json = JSON.parse(response.body)
        data = json["data"]["survey_responses"]

        expect(data).to be_nil
      end
    end

    describe "student surveys .resolve" do
      let(:volunteer) { create(:user, :volunteer) }

      before do
        adam = create(:student, first_name: "Adam", last_name: "Ruby")
        gia = create(:student, first_name: "Gia", last_name: "ForGood")
        travel_to(yesterday) do
          create_response(volunteer, adam, 42, Time.zone.now - 6.hours)
          create_response(volunteer, gia, 46, Time.zone.now - 4.hours)
        end
      end

      context "when signed in" do
        it "returns all survey_responses belonging to user and student", :aggregate_failures do
          sign_in(volunteer)
          adam = Student.find_by(first_name: "Adam", last_name: "Ruby")

          post "/graphql", params: {query: student_query(adam)}

          expect(response).to be_successful
          json = JSON.parse(response.body)
          data = json["data"]["studentSurveyResponses"]

          expect(data.size).to eq(1)
          expect(data[0]["student"]["name"]).to eq("Adam Ruby")
        end
      end

      it "returns nothing when not signed in", :aggregate_failures do
        adam = Student.find_by(first_name: "Adam", last_name: "Ruby")
        post "/graphql", params: {query: student_query(adam)}
        expect(response).to be_successful

        json = JSON.parse(response.body)
        data = json["data"]["survey_responses"]

        expect(data).to be_nil
      end
    end

    def yesterday
      @yesterday ||= Time.zone.now.yesterday
    end

    def parse_time(date)
      Time.parse(date).strftime("%F").to_s
    end
  end
end
