# frozen_string_literal: true

class CreateSurveyQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :survey_questions do |t|
      t.references :survey, null: false, foreign_key: true
      t.string :type
      t.text :prompt

      t.timestamps
    end
  end
end
