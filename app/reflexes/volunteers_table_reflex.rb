# frozen_string_literal: true

class VolunteersTableReflex < ApplicationReflex
  include SortHelper

  def sort
    sort_records(records: records,
                 partial: "volunteers_table",
                 columns: %w[first_name last_name status])
  end

  def filter
    filter_records(records: records,
                   partial: "volunteers_table",
                   columns: { first_name: :fuzzy, last_name: :fuzzy, status: :exact })
  end

  private

  def records
    return @records if defined?(@records)

    @records = User.where(role: :volunteer)
  end
end
