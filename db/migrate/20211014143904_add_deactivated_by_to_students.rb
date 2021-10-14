class AddDeactivatedByToStudents < ActiveRecord::Migration[6.1]
  def change
    add_column :students, :deactivator_id, :bigint, null: true
    add_index :students, :deactivator_id
  end
end
