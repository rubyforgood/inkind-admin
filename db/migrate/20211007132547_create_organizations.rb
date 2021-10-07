# frozen_string_literal: true

class CreateOrganizations < ActiveRecord::Migration[6.1]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :email
      t.string :phone_number
      t.string :address1
      t.string :address2
      t.string :zip_code
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
