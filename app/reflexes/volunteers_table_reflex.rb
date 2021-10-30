# frozen_string_literal: true

class VolunteersTableReflex < ApplicationReflex
  include Tabular

  def sort
    params[:order_by] = element.dataset.column
    params[:direction] = element.dataset.direction
    update_client
  end

  def paginate
    params[:page] = element.dataset[:page].to_i
    update_client
  end

  private

  def update_client
    prepare_variables

    volunteers = User.where(role: :volunteer).order("#{@order_by} #{@direction}")
    @pagy, @volunteers = pagy(volunteers, page: @page)

    assigns = {
      order_by: @order_by,
      direction: @direction,
      page: @page,
      pagy: @pagy,
      volunteers: @volunteers
    }

    morph "#volunteers", render(partial: "admin/volunteers/volunteers_table", assigns: assigns)
    morph "#paginator", render(partial: "admin/shared/paginator", assigns: assigns)
  end
end
