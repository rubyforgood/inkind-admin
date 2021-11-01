class DropStudentsUsers < ActiveRecord::Migration[6.1]
  def up
    drop_table :students_users
  end

  def down
  end
end
