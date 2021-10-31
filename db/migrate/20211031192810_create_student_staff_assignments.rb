class CreateStudentStaffAssignments < ActiveRecord::Migration[6.1]
  def change
    create_table :student_staff_assignments do |t|
      t.references :student, null: false, foreign_key: true
      t.references :staff, null: false, foreign_key: {to_table: "users"}

      t.date :start_date, null: false, default: -> { "CURRENT_DATE" }
      t.date :end_date, null: false, default: "3000-01-01"

      t.timestamps
    end
  end
end
