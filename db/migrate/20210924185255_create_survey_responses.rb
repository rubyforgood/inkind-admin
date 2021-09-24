class CreateSurveyResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :survey_responses do |t|
      t.references :survey, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true

      t.timestamps
    end
  end
end
