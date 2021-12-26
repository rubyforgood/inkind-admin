class AddGuardianEmailToStudents < ActiveRecord::Migration[6.1]
  def change
    add_column :students, :guardian_email, :string, null: true
  end
end
