module Admin
  class StudentsController < ApplicationController
    before_action :set_student, only: %i[show edit update destroy]

    # GET /students
    def index
      @students = Student.all
    end

    # GET /students/1
    def show; end

    # GET /students/new
    def new
      @student = Student.new
    end

    # GET /students/1/edit
    def edit; end

    # POST /students
    def create
      @student = Student.new(student_params)

      if @student.save
        redirect_to admin_student_path(@student), notice: 'Student was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /students/1
    def update
      if @student.update(student_params)
        redirect_to admin_student_path(@student), notice: 'Student was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /students/1
    def destroy
      @student.destroy
      redirect_to admin_students_url, notice: 'Student was successfully destroyed.'
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:first_name, :last_name, :email, :date_of_birth, :phone_number, :status,
                                      :guardian_name, :guardian_phone_number, :emergency_contact_name, :emergency_contact_phone_number, :deactivated_at)
    end
  end
end
