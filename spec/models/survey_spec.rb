require "rails_helper"

RSpec.describe Survey, type: :model do
  it "has valid factory" do
    expect(create(:survey)).to be_valid
  end

  context "associations" do
    it { is_expected.to have_many(:questions).class_name("SurveyQuestion") }
    it { is_expected.to have_many(:responses).class_name("SurveyResponse") }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end

  context "enum" do
    it { is_expected.to define_enum_for(:status).with_values(inactive: 0, active: 1) }
  end
end
