require "rails_helper"

RSpec.describe Organization, type: :model do
  it "has valid factory" do
    expect(create(:organization)).to be_valid
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end
end
