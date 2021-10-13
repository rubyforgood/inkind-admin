require "rails_helper"

RSpec.describe SupportTicket, type: :model do
  it "has valid factory" do
    expect(create(:support_ticket)).to be_valid
  end
end
