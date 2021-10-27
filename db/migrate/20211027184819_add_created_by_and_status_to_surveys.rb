class AddCreatedByAndStatusToSurveys < ActiveRecord::Migration[6.1]
  def change
    add_column :surveys, :status, :integer, default: 0, null: false
    add_column :surveys, :creator_id, :bigint
  end
end
