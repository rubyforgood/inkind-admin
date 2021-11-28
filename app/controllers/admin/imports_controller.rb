module Admin
  class ImportsController < ApplicationController
    def volunteers
      result = import_for(User, { skip_password_validation: true })
      flash[:alert] = "Imported #{result.count} Volunteers"
      redirect_to admin_volunteers_path
    end

    def students
      result = import_for(Student)
      flash[:alert] = "Imported #{result.count} Students"
      redirect_to admin_students_path
    end

  private

    def import_for(model, additional_properties = {})
      Importer::Csv.import(file_params[:file].tempfile, model, additional_properties)
    end

    def file_params
      params.permit(:file)
    end
  end
end
