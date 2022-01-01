# frozen_string_literal: true

class AdminsTableReflex < ApplicationReflex
  include TableHelper

  def sort
    sort_records(records: User.where(role: :admin),
      columns: %w[first_name last_name status])
  end

  private

  def partial
    "admins_table"
  end
end
