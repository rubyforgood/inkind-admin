require "rails_helper"

RSpec.describe SurveyResponse, type: :model do
  it "has valid factory" do
    expect(create(:survey_response)).to be_valid
  end

  context "associations" do
    it { is_expected.to belong_to(:volunteer).class_name("User") }
    it { is_expected.to belong_to(:student) }
    it { is_expected.to belong_to(:survey) }
    it { is_expected.to have_one(:meeting_duration) }
    it { is_expected.to have_many(:question_responses).class_name("SurveyQuestionResponse") }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:volunteer) }
    it { is_expected.to validate_presence_of(:student) }
    it { is_expected.to validate_presence_of(:survey) }
  end

  context "enum" do
    it { is_expected.to define_enum_for(:status).with_values(incomplete: 0, complete: 1) }
  end
end
