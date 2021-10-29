require "rails_helper"

RSpec.describe SurveyQuestion, type: :model do
  it "has valid factory" do
    expect(create(:survey_question)).to be_valid
  end

  context "associations" do
    it { is_expected.to belong_to(:survey) }
  end
end
