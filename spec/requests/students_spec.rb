require "rails_helper"

RSpec.describe "/admin/students", type: :request do
  before(:each) do
    sign_in create(:user, role: :admin)
  end

  let(:valid_attributes) do
    attributes_for(:student)
  end

  let(:invalid_attributes) do
    attributes_for(:student, first_name: "", last_name: "")
  end

  describe "GET /index" do
    context "with format csv" do
      it "generates the csv file" do
        travel_to(Date.new(2021, 10, 14)) do
          create(:student, first_name: "Campbell", last_name: "McClure", email: "laila@koelpin.io", status: :active, date_of_birth: Date.new(2010, 8, 6))
          create(:student, first_name: "Indigo", last_name: "Torp", email: "denese.mcglynn@breitenberg.io", status: :inactive, date_of_birth: Date.new(2012, 7, 7))

          get admin_students_url, params: {format: :csv}

          expect(response.header["Content-Type"]).to include "text/csv"
          expect(response.headers["Content-Disposition"]).to include "attachment; filename=\"students-2021-10-14.csv\""
          expect(response.body).to eq <<~CSV
            "name","guardian_name","date_of_birth","status"
            "Campbell McClure","","2010-08-06","active"
            "Indigo Torp","","2012-07-07","inactive"
          CSV
        end
      end
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Student" do
        expect do
          post admin_students_path, params: {student: valid_attributes}
        end.to change(Student, :count).by(1)
      end

      it "redirects to the created student" do
        post admin_students_url, params: {student: valid_attributes}
        expect(response).to redirect_to(admin_students_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new student" do
        expect do
          post admin_students_url, params: {student: invalid_attributes}
        end.to change(Student, :count).by(0)
      end

      it "renders a successful response" do
        post admin_students_url, params: {student: invalid_attributes}
        expect(response).to be_successful
      end
    end

    context "with invalid parameters" do
      it "renders a successful response" do
        volunteer = Student.create! valid_attributes
        patch admin_student_url(volunteer), params: {student: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end
end
