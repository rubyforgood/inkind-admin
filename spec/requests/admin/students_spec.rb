require "rails_helper"

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/admin/students", type: :request do
  # Student. As you add validations to Student, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    attributes_for(:student)
  end

  let(:invalid_attributes) do
    attributes_for(:student, last_name: "")
  end

  describe "GET /index" do
    it "renders a successful response" do
      Student.create! valid_attributes
      get admin_students_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      student = Student.create! valid_attributes
      get admin_student_url(student)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_admin_student_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      student = Student.create! valid_attributes
      get edit_admin_student_url(student)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Student" do
        expect do
          post admin_students_url, params: {student: valid_attributes}
        end.to change(Student, :count).by(1)
      end

      it "redirects to the created student" do
        post admin_students_url, params: {student: valid_attributes}
        expect(response).to redirect_to(admin_student_url(Student.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Student" do
        expect do
          post admin_students_url, params: {student: invalid_attributes}
        end.to change(Student, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post admin_students_url, params: {student: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        skip("Add a hash of attributes valid for your model")
      end

      it "updates the requested student" do
        student = Student.create! valid_attributes
        patch admin_student_url(student), params: {student: new_attributes}
        student.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the student" do
        student = Student.create! valid_attributes
        patch admin_student_url(student), params: {student: new_attributes}
        student.reload
        expect(response).to redirect_to(admin_student_url(student))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        student = Student.create! valid_attributes
        patch admin_student_url(student), params: {student: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested student" do
      student = Student.create! valid_attributes
      expect do
        delete admin_student_url(student)
      end.to change(Student, :count).by(-1)
    end

    it "redirects to the students list" do
      student = Student.create! valid_attributes
      delete admin_student_url(student)
      expect(response).to redirect_to(admin_students_url)
    end
  end
end