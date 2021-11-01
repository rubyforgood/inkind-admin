require "rails_helper"

RSpec.describe "/admin/students", type: :request do
  before { sign_in(create(:user, role: :admin)) }

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

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new Student" do
        expect do
          post admin_students_path, params: {student: attributes_for(:student)}
        end.to change(Student, :count).by(1)
      end

      it "redirects to the created student" do
        post admin_students_url, params: {student: attributes_for(:student)}
        expect(response).to redirect_to(admin_students_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new student" do
        expect do
          post admin_students_url, params: {student: attributes_for(:student, last_name: "")}
        end.to change(Student, :count).by(0)
      end

      it "renders a successful response" do
        post admin_students_url, params: {student: attributes_for(:student, last_name: "")}
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH #update" do
    context "with invalid parameters" do
      it "renders a successful response" do
        student = Student.create(attributes_for(:student))
        patch admin_student_url(student), params: {student: attributes_for(:student, last_name: "")}
        expect(response).to be_successful
      end
    end

    context "assigns volunteer to student" do
      it "affiliates a volunteer with the student", :aggregate_failures do
        volunteer = create(:volunteer)
        student = create(:student)
        expect do
          patch admin_student_url(student), params: {student: student.attributes.merge("volunteer_id" => volunteer.id)}
        end.to change(StudentVolunteerAssignment, :count).by(1)
        expect(student.active_student_volunteer_assignment).to eq StudentVolunteerAssignment.last
        expect(student.volunteers).to include(volunteer)
      end

      it "remove volunteer from student & mark end of assignment" do
        volunteer = create(:volunteer)
        student = create(:student)
        student_volunteer_assignment = create(:student_volunteer_assignment, student: student, volunteer: volunteer)
        expect do
          patch admin_student_url(student), params: {student: student.attributes}
        end.to_not change(StudentVolunteerAssignment, :count)
        expect(student.active_student_volunteer_assignment).to eq nil
        expect(student_volunteer_assignment.reload.end_date).to eq Date.current
      end
    end

    context "assigns staff to student" do
      it "affiliates a staff contact with the student", :aggregate_failures do
        staff = create(:staff)
        student = create(:student)
        expect do
          patch admin_student_url(student), params: {student: student.attributes.merge("staff_id" => staff.id)}
        end.to change(StudentStaffAssignment, :count).by(1)
        expect(student.active_student_staff_assignment).to eq StudentStaffAssignment.last
      end

      it "remove staff from student & mark end of assignment" do
        staff = create(:staff)
        student = create(:student)
        student_staff_assignment = create(:student_staff_assignment, student: student, staff: staff)
        expect do
          patch admin_student_url(student), params: {student: student.attributes}
        end.to_not change(StudentStaffAssignment, :count)
        expect(student.active_student_staff_assignment).to eq nil
        expect(student_staff_assignment.reload.end_date).to eq Date.current
      end
    end
  end
end
