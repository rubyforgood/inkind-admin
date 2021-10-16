class AddCategoryToSupportTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :support_tickets, :category, :integer, default: 0, null: false
  end
end
