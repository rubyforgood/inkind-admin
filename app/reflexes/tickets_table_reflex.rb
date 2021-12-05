# frozen_string_literal: true

class TicketsTableReflex < ApplicationReflex
  include SortHelper

  def sort
    sort_records(records: SupportTicket.all,
      partial: "tickets_table",
      sort_columns: %w[created_at status])
  end
end
