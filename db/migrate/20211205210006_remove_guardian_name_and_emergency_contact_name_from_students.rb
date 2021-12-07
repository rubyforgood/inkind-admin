class RemoveGuardianNameAndEmergencyContactNameFromStudents < ActiveRecord::Migration[6.1]
  def change
    remove_column :students, :guardian_name, :string
    remove_column :students, :emergency_contact_name, :string
  end
end
