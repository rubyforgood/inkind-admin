class AddStatusToSurveyResponses < ActiveRecord::Migration[6.1]
  def change
    add_column :survey_responses, :status, :integer, default: 0, null: false
  end
end
