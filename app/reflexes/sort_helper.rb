# frozen_string_literal: true

module SortHelper
  def sort_records(records:, partial:, sort_columns:)
    # Although risk of sql injection on `order` is pretty low with rails 6.1. IMO It is better to validate the input.
    sort_column = sort_columns.include?(element.dataset.column) ? element.dataset.column : sort_columns.first

    records.order!("#{sort_column} #{sort_direction}")

    set_sort_direction
    insert_indicator

    morph '#sortable', render(partial: partial, locals: {records: records})
  end

  private

  # Although risk of sql injection on `order` is pretty low with rails 6.1. IMO It is better to validate the input.
  def sort_direction
    return @sort_direction if defined?(@sort_direction)

    @sort_direction = %w[asc desc].include?(element.dataset.direction) ? element.dataset.direction : "asc"
  end

  def next_direction
    sort_direction == "asc" ? "desc" : "asc"
  end

  def set_sort_direction
    cable_ready
      .set_dataset_property(
        selector: "##{element.id}",
        name: "direction",
        value: next_direction
      )
  end

  def insert_indicator
    cable_ready
      .prepend(
        selector: "##{element.id}",
        html: render(
          partial: "partials/sort_indicator",
          locals: {direction: sort_direction}
        )
      )
  end
end
