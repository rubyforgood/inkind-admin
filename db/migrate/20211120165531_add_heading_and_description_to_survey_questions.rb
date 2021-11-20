class AddHeadingAndDescriptionToSurveyQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :survey_questions, :heading, :string
    add_column :survey_questions, :description, :text
  end
end
