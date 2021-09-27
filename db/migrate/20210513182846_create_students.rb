class CreateStudents < ActiveRecord::Migration[6.1]
  def change
    create_table :students do |t|
      t.string :name, null: false
      t.string :nickname, null: true
      t.string :email
      t.string :phone_number, null: true
      t.integer :status, default: 0, null: false
      t.string :guardian_name
      t.string :guardian_phone_number, null: true
      t.string :emergency_contact_name
      t.string :emergency_contact_phone_number, null: true
      t.date :date_of_birth
      t.datetime :deactivated_at

      t.timestamps
    end
  end
end
