# frozen_string_literal: true

class CreateSurveyQuestionOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :survey_question_options do |t|
      t.references :survey_question, null: false, foriegn_key: true
      t.string :label

      t.timestamps
    end
  end
end
