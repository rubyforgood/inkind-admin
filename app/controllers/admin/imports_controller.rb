module Admin
  class ImportsController < ApplicationController
    def volunteers
      result = import_for(User, {skip_password_validation: true})
      flash[:alert] = "Imported #{result.count} Volunteers"
      redirect_to admin_volunteers_path
    end

  private
    def import_for(model, extras)
      Importer::Csv.import(file_params[:file].tempfile, model, extras)
    end

    def file_params
      params.permit(:file)
    end
  end
end
