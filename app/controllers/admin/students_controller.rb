class Admin::StudentsController < ApplicationController
  before_action :set_admin_student, only: [:show, :edit, :update, :destroy]

  # GET /admin/students
  def index
    @admin_students = Admin::Student.all
  end

  # GET /admin/students/1
  def show
  end

  # GET /admin/students/new
  def new
    @admin_student = Admin::Student.new
  end

  # GET /admin/students/1/edit
  def edit
  end

  # POST /admin/students
  def create
    @admin_student = Admin::Student.new(admin_student_params)

    if @admin_student.save
      redirect_to @admin_student, notice: 'Student was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/students/1
  def update
    if @admin_student.update(admin_student_params)
      redirect_to @admin_student, notice: 'Student was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/students/1
  def destroy
    @admin_student.destroy
    redirect_to admin_students_url, notice: 'Student was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_student
      @admin_student = Admin::Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_student_params
      params.fetch(:admin_student, {})
    end
end
