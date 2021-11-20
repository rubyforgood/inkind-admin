require "rails_helper"

RSpec.describe SurveyQuestion, type: :model do
  it "has valid factory" do
    expect(create(:survey_question)).to be_valid
  end

  context "associations" do
    it { is_expected.to belong_to(:survey) }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:prompt) }
    it { is_expected.to validate_length_of(:heading).is_at_most(400) }
    it { is_expected.to validate_length_of(:prompt).is_at_most(10_000) }
    it { is_expected.to validate_length_of(:description).is_at_most(10_000) }
  end
end
