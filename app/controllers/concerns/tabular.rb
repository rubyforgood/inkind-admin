module Tabular
  extend ActiveSupport::Concern
  include Pagy::Backend

  protected

  def prepare_variables
    @order_by = params[:order_by]
    @direction = params[:direction]
    @page = (params[:page] || 1).to_i
  end
end
