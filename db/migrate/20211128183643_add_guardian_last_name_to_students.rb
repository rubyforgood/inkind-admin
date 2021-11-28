class AddGuardianLastNameToStudents < ActiveRecord::Migration[6.1]
  def change
    add_column :students, :guardian_last_name, :string
  end
end
