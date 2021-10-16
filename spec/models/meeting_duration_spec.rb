require "rails_helper"

RSpec.describe MeetingDuration, type: :model do
  it "has valid factory" do
    expect(create(:meeting_duration)).to be_valid
  end

  it "marks status of survey response to upon creation" do
    survey_response = create(:survey_response, status: :incomplete)

    create(:meeting_duration, survey_response: survey_response)

    expect(survey_response.reload.status).to eq "complete"
  end
end
