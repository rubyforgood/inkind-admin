class CreateSurveyQuestionOptionResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :survey_question_option_responses do |t|
      t.references :survey_question_option, null: false,
                                            foriegn_key: true,
                                            index: {
                                              name: "index_question_option_responses_on_question_option"
                                            }
      t.references :survey_question_response, null: false,
                                              foriegn_key: true,
                                              index: {
                                                name: "index_question_option_responses_on_question_response"
                                              }

      t.timestamps
    end
  end
end
