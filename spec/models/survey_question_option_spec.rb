require "rails_helper"

RSpec.describe SurveyQuestionOption, type: :model do
  it "has valid factory" do
    expect(create(:survey_question_option)).to be_valid
  end
end
