class StudentsUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :students_users do |t|
      t.references :student, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
