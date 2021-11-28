class AddEmergencyContactLastNameToStudents < ActiveRecord::Migration[6.1]
  def change
    add_column :students, :emergency_contact_last_name, :string
  end
end
