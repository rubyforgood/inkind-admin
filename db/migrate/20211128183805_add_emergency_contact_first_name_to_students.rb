class AddEmergencyContactFirstNameToStudents < ActiveRecord::Migration[6.1]
  def change
    add_column :students, :emergency_contact_first_name, :string
  end
end
