require "rails_helper"

RSpec.describe SurveyQuestionOption, type: :model do
  it "has valid factory" do
    expect(create(:survey_question_option)).to be_valid
  end

  context "associations" do
    it { is_expected.to belong_to(:question).class_name("SurveyQuestion") }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:label) }
  end
end
