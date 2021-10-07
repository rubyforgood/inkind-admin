require "rails_helper"

RSpec.describe Organization, type: :model do
  it "has valid factory" do
    expect(create(:organization)).to be_valid
  end
end
