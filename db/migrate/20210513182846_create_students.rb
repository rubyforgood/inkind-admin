class CreateStudents < ActiveRecord::Migration[6.1]
  def change
    create_table :students do |t|
      t.string :name, null: false
      t.string :email
      t.date :date_of_birth
      t.string :location
      t.string :phone_number
      t.string :preferred_contact_method
      t.datetime :archived_at
      t.string :nickname

      t.timestamps
    end
  end
end
