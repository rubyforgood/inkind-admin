require 'rails_helper'

RSpec.describe SurveyQuestionResponse, type: :model do
  it "has valid factory" do
    expect(create(:survey_question_response)).to be_valid
  end
end
