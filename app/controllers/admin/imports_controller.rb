module Admin
  class ImportsController < ApplicationController
    def volunteers
      result = import_for(User, {skip_password_validation: true})
      flash[:alert] = "Imported #{result.count} Volunteers"
      redirect_to admin_volunteers_path
    end

    private

<<<<<<< HEAD
    def import_for(model, extras)
      Importer::Csv.import(file_params[:file].tempfile, model, extras)
=======
    def import_for(model, additional_properties = {})
      Importer::Csv.import(file_params[:file].tempfile, model, additional_properties)
>>>>>>> main
    end

    def file_params
      params.permit(:file)
    end
  end
end
