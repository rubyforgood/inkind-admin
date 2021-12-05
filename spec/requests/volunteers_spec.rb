require "rails_helper"

RSpec.describe "/admin/volunteers", type: :request do
  before(:each) do
    sign_in create(:user, role: :admin)
  end

  let(:valid_attributes) do
    attributes_for(:user)
  end

  let(:invalid_attributes) do
    attributes_for(:user, email: "")
  end

  describe "GET /index" do
    context "with format csv" do
      it "generates csv file", :aggregate_failures do
        travel_to(Date.new(2021, 10, 14)) do
          volunteer1 = create(:volunteer, first_name: "Zion", last_name: "Vandervort", email: "volunteer-1@example.edu", status: :inactive)
          create(:support_ticket, requestor: volunteer1)
          create(:support_ticket, requestor: volunteer1)

          volunteer2 = create(:volunteer, first_name: "Sutton", last_name: "Faddel", email: "volunteer-2@example.edu", phone_number: "123-456-7890")
          student = create(:student, first_name: "Jim", last_name: "Adil")
          create(:student_volunteer_assignment, student: student, volunteer: volunteer2)

          create(:survey_response, volunteer: volunteer2, meeting_duration: build(:meeting_duration))
          create(:survey_response, volunteer: volunteer2, meeting_duration: build(:meeting_duration))
          create(:survey_response, volunteer: volunteer2, meeting_duration: nil)

          create(:support_ticket, requestor: volunteer2)

          get admin_volunteers_url, params: {format: :csv}

          expect(response.header["Content-Type"]).to include "text/csv"
          expect(response.headers["Content-Disposition"]).to include "attachment; filename=\"volunteers-2021-10-14.csv\""
          response_rows = response.body.split("\n")
          sanitized_response_headers = response_rows.first.split(",").map { |header| header.delete('\"') }
          sanitized_first_row = response_rows.second.split(",").map { |header| header.delete('\"') }
          sanitized_second_row = response_rows.third.split(",").map { |header| header.delete('\"') }

          expect(sanitized_response_headers).to eq User::VOLUNTEER_EXPORT_HEADERS
          expect(sanitized_first_row).to eq(
            ["Sutton Faddel", "active", "volunteer-2@example.edu", volunteer2.phone_number, student.name, "", "10/14/2021", "2", "90", "true", "1"]
          )
          expect(sanitized_second_row).to eq(
            ["Zion Vandervort", "inactive", "volunteer-1@example.edu", "", "", "", "", "0", "0", "true", "2"]
          )
        end
      end
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Volunteer" do
        expect do
          post admin_volunteers_path, params: {user: valid_attributes}
        end.to change(User, :count).by(1)
      end

      it "redirects to the created volunteer" do
        post admin_volunteers_url, params: {user: valid_attributes}
        expect(response).to redirect_to(admin_volunteers_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new volunteer" do
        expect do
          post admin_volunteers_url, params: {user: invalid_attributes}
        end.to change(User, :count).by(0)
      end

      it "renders a successful response" do
        post admin_volunteers_url, params: {user: invalid_attributes}
        expect(response).to be_successful
      end
    end

    context "with invalid parameters" do
      it "renders a successful response" do
        volunteer = User.create! valid_attributes
        patch admin_volunteer_url(volunteer), params: {user: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end
end
