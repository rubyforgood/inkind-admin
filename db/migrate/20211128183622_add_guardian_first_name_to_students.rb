class AddGuardianFirstNameToStudents < ActiveRecord::Migration[6.1]
  def change
    add_column :students, :guardian_first_name, :string
  end
end
