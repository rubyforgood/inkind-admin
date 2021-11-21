# frozen_string_literal: true

class VolunteersTableReflex < ApplicationReflex
  include SortHelper

  def sort
    sort_records(records: User.where(role: :volunteer),
      partial: "volunteers_table",
      sort_columns: ["first_name", "last_name", "status"])
  end
end
