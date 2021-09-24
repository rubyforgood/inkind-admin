require 'rails_helper'

RSpec.describe SurveyResponse, type: :model do
  it "has valid factory" do
    expect(create(:survey_response)).to be_valid
  end
end
