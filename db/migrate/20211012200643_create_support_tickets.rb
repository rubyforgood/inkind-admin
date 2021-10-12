class CreateSupportTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :support_tickets do |t|
      t.references :requestor, references: :users, null: false
      t.string :description
      t.integer :status, default: 0, null: false
      t.datetime :closed_at
      t.references :closer, references: :users
      t.text :closer_notes
      t.references :survey_response, null: true

      t.timestamps
    end
  end
end
