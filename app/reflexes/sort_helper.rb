# frozen_string_literal: true

module SortHelper
  def sort_records(records:, partial:, columns:)
    column = filter_columns(columns: columns)

    records.order!(column => sort_direction)

    set_sort_direction
    insert_indicator

    morph "#sortable", render(partial: partial, locals: { records: records })
  end

  def filter_records(records:, partial:, columns:)
    column = filter_columns(columns: columns.keys)
    search_type = columns[column]

    if search_type == :fuzzy
      table = records.arel_table
      records = records.where(table[column].matches("%#{element.value}%"))
    elsif search_type == :exact
      records = records.where(column => element.value)
    end

    morph "#sortable", render(partial: partial, locals: { records: records})
  end

  private

  def filter_columns(columns:)
    columns.include?(element.dataset.column) ? element.dataset.column : columns.first
  end

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
