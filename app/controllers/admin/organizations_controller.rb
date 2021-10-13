module Admin
  class OrganizationsController < ApplicationController

    def show
      @organization = Organization.find(params[:id])
    end

    def edit
      @organization = Organization.find(params[:id])
    end

    def update
      @organization = Organization.find(params[:id])
      if @organization.update(organization_params)
        flash[:success] = "Saved!"
      else
        flash.now[:error] = "Missing information"
        render :edit
      end
    end

private
    def organization_params
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