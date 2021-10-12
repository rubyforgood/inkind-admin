module Admin
  class OrganizationsController < ApplicationController
    def index
      @organizations = Organization.all
    end

    def show
      @organization = Organization.find(params[:id])
    end

    def edit
      @organization = Organization.find(params[:id])
    end

    def update
      @organization = Organization.find(params[:id])
      if @organization.update(organizations_params)
        flash[:success] = "Saved!"
        redirect_to admin_organization_path(@organization)
      else
        flash.now[:error] = "Missing information"
        render :edit
      end
    end

  private
    def organizations_params
      params.require(:organization).permit(
        :name, 
        :email, 
        :phone_number, 
        :address1, 
        :address2, 
        :zip_code, 
        :city, 
        :state)
    end
  end
end