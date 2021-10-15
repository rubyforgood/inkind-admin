class AddDeactivatedByToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :deactivator_id, :bigint, null: true
    add_index :users, :deactivator_id
  end
end
