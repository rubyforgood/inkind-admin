require "rails_helper"

RSpec.describe MeetingDuration, type: :model do
  it "has valid factory" do
    expect(create(:meeting_duration)).to be_valid
  end

  context "associations" do
    it { is_expected.to belong_to(:survey_response) }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:minutes) }
    it { is_expected.to validate_presence_of(:started_at) }
    it { is_expected.to validate_presence_of(:survey_response) }
  end

  it "marks status of survey response to 'complete' upon creation" do
    survey_response = create(:survey_response, status: :incomplete)

    create(:meeting_duration, survey_response: survey_response)

    expect(survey_response.reload.status).to eq "complete"
  end
end
