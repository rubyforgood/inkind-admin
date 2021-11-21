# frozen_string_literal: true

class AdminsTableReflex < ApplicationReflex
  include SortHelper

  def sort
    sort_records(records: User.where(role: :admin),
      partial: "admins_table",
      sort_columns: ["first_name", "last_name", "status"])
  end
end
