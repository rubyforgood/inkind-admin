# frozen_string_literal: true

class VolunteersTableReflex < ApplicationReflex
  include Tabular

  def sort
    params[:order_by] = element.dataset.column
    params[:direction] = element.dataset.direction

    volunteers = User.where(role: :volunteer).order("#{@order_by} #{@direction}")
    @pagy, @volunteers = pagy(volunteers, page: @page)

    update_client
    # prepare_variables

    # assigns = {
    #   order_by: @order_by,
    #   direction: @direction,
    #   page: @page,
    #   pagy: @pagy,
    #   volunteers: @volunteers
    # }

    # morph "#volunteers", render(partial: "volunteers_table", locals: {volunteers: volunteers})
    # morph "#volunteers", render(partial: "volunteers_table", assigns: assigns)


    # morph "#volunteers", render(partial: "volunteers_table", assigns: assigns)
  end

  def paginate
    params[:page] = element.dataset[:page].to_i
    update_client
  end

  private

  def do_assign()
  end

  def update_client()
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

    uri = URI.parse([request.base_url, request.path].join)
    uri.query = assigns.except(:volunteers, :pagy).to_query

    morph :nothing

    cable_ready
      .inner_html(selector: "#volunteers", html: render(partial: "volunteers_table", assigns: assigns))
      .push_state(url: uri.to_s)
      .broadcast

    # morph "#volunteers", render(partial: "volunteers_table", assigns: assigns)
  end
end
