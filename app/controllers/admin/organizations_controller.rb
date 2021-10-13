module Admin
  class OrganizationsController < ApplicationController
    def edit
      @organization = Organization.find(params[:id])
    end

    def update
      @organization = Organization.find(params[:id])
      if @organization.update(organization_params)
        redirect_to edit_admin_organization_path(@organization), notice: "Organization was successfully updated."
      else
        flash[:alert] = format_errors(@organization)
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
        :state
      )
    end
  end
end
