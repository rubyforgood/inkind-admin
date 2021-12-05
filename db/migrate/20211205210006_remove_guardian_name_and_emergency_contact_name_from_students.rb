class RemoveGuardianNameAndEmergencyContactNameFromStudents < ActiveRecord::Migration[6.1]
  def change
    remove_column :students, :guardian_name, :emergency_contact_name
  end
end
