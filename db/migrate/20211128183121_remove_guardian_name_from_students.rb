class RemoveGuardianNameFromStudents < ActiveRecord::Migration[6.1]
  def change
    remove_column :students, :guardian_name, :string
  end
end
