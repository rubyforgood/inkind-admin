require 'rails_helper'

RSpec.describe MeetingDuration, type: :model do
  it "has valid factory" do
    expect(create(:meeting_duration)).to be_valid
  end
end
