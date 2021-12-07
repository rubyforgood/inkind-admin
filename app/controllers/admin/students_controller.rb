module Admin
  class StudentsController < ApplicationController
    def index
      @nav = "Students"
      @students = Student.order(:last_name)

      respond_to do |format|
        format.html
        format.csv do
          send_data Student.export_to_csv(@students, columns: %w[name guardian_last_name date_of_birth status]), filename: "students-#{Date.today}.csv"
        end
      end
    end

    def new
      @student = Student.new
    end

    def edit
      @student = Student.find(params[:id])
    end

    def create
      @student = Student.new(students_params)

      if @student.valid?
        @student.save!
        redirect_to admin_students_url, notice: "Student was successfully created."
      else
        flash[:alert] = format_errors(@student)
        render :new
      end
    end

    def update
      @student = Student.find(params[:id])

      if @student.update_with_assignments!(
        student_attributes: students_params.except(:volunteer_ids),
        volunteer_ids: params[:student][:volunteer_ids],
        staff_id: params[:student][:staff_id]
      )
        redirect_to admin_students_url, notice: "Student was successfully updated."
      else
        flash[:alert] = format_errors(@student)
        render :edit
      end
    end

    def activate
      @student = Student.find(params[:id])
      @student.activate!

      redirect_to admin_students_url, notice: "Student was successfully activated."
    end

    def deactivate
      @student = Student.find(params[:id])

      @student.deactivate!(deactivator_id: current_user.id)

      redirect_to admin_students_url, notice: "Student was successfully deactivated."
    end

    def students_params
      params.require(:student).permit(:first_name, :last_name,
        :email, :phone_number, :guardian_phone_number, :guardian_first_name,
        :guardian_last_name, :emergency_contact_first_name, :emergency_contact_last_name,
        :emergency_contact_phone_number, :date_of_birth, volunteer_ids: [])
    end
  end
end
