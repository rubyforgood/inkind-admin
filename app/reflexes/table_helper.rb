# frozen_string_literal: true

module TableHelper
  def sort_records(records:, columns:)
    column = filter_columns(columns: columns)

    records.order!(column => sort_direction)

    set_sort_direction
    insert_indicator

    morph "#sortable", render(partial: partial, locals: {records: records})
  end

  def filter_records(records:, columns:)
    column = filter_columns(columns: columns.keys.concat(special_filters))
    filters = session_filters.merge!(column => element.value).except(*special_filters)

    table = records.arel_table
    query_params = filters.map do |k, v|
      next if v.blank?

      if columns[k] == :fuzzy
        table[k].matches("%#{v}%")
      elsif columns[k] == :exact
        table[k].eq(v)
      end
    end.compact_blank

    records = records.where(query_params.inject(&:and))
    if session_filters.keys.intersection(special_filters).present?
      records = run_special_filters(filters: session_filters,
        records: records)
    end

    morph "#sortable", render(partial: partial, locals: {records: records})
  end

  private

  def session_filters
    session[:filters][partial.to_sym]
  end

  def special_filters
    []
  end

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
