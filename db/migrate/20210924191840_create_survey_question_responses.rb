class CreateSurveyQuestionResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :survey_question_responses do |t|
      t.references :survey_response, null: false, foriegn_key: true
      t.references :survey_question, null: false, foriegn_key: true
      t.text :reply, null: true

      t.timestamps
    end
  end
end
