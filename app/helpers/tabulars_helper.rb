module TabularsHelper
  include Pagy::Frontend

  def arrow(column_name)
    return if column_name.to_s != @order_by
    @direction == "asc" ? "↑" : "↓"
  end

  def direction
    @direction == "asc" ? "desc" : "asc"
  end

  def pagy_get_params(params)
    params.merge order_by: @order_by, direction: @direction
  end

  def prev_page
    @pagy.prev || 1
  end

  def next_page
    @pagy.next || @pagy.last
  end
end
