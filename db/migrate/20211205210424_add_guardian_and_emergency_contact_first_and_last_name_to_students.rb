class AddGuardianAndEmergencyContactFirstAndLastNameToStudents < ActiveRecord::Migration[6.1]
  def change
    add_column :students, :guardian_first_name, :string
    add_column :students, :guardian_last_name, :string
    add_column :students, :emergency_contact_first_name, :string
    add_column :students, :emergency_contact_last_name, :string
  end
end
