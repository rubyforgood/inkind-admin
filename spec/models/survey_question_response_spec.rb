require "rails_helper"

RSpec.describe SurveyQuestionResponse, type: :model do
  it "has valid factory" do
    expect(create(:survey_question_response)).to be_valid
  end

  context "associations" do
    it { is_expected.to belong_to(:response).class_name("SurveyResponse") }
    it { is_expected.to belong_to(:question).class_name("SurveyQuestion") }
  end
end
