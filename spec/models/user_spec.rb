require "rails_helper"

RSpec.describe User, type: :model do
  it "has valid factory" do
    expect(build(:user)).to be_valid
  end

  context "associations" do
    it { is_expected.to have_many(:survey_responses) }
    it { is_expected.to have_many(:students_users) }
    it { is_expected.to have_many(:students).through(:students_users) }
  end

  context "enum" do
    it { is_expected.to define_enum_for(:status).with_values(active: 0, inactive: 1) }
    it { is_expected.to define_enum_for(:role).with_values(volunteer: 0, admin: 1) }
  end

  context "roles" do
    it "admin", :aggregate_failures do
      admin = create(:user, :admin)
      expect(admin).to_not be_new_record
      expect(admin).to be_admin
    end

    it "volunteer", :aggregate_failures do
      volunteer = create(:user, :volunteer)
      expect(volunteer).to_not be_new_record
      expect(volunteer).to be_volunteer
    end
  end
end
