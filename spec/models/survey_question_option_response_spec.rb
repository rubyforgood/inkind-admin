require "rails_helper"

RSpec.describe SurveyQuestionOptionResponse, type: :model do
  it "has valid factory" do
    expect(create(:survey_question_option_response)).to be_valid
  end

  context "associations" do
    it { is_expected.to belong_to(:option).class_name("SurveyQuestionOption") }
    it { is_expected.to belong_to(:question_response).class_name("SurveyQuestionResponse") }
  end
end
