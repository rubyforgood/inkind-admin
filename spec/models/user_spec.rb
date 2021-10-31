require "rails_helper"

RSpec.describe User, type: :model do
  subject(:user) { create(:user) }

  it "has valid factory" do
    expect(build(:user)).to be_valid
  end

  context "associations" do
    it { is_expected.to have_many(:survey_responses) }
    it { is_expected.to have_many(:support_tickets) }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
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

  context "activation" do
    it "can be activated" do
      admin = create(:user, :volunteer)
      volunteer = create(:user, :volunteer, status: :inactive, deactivated_at: Time.now, deactivator_id: admin.id)
      expect(volunteer.status).to eq("inactive")

      volunteer.activate!
      expect(volunteer.status).to eq("active")
    end

    it "can be deactivated" do
      admin = create(:user, :volunteer)
      volunteer = create(:user, :volunteer)

      volunteer.deactivate!(deactivator_id: admin.id)
      expect(volunteer.status).to eq("inactive")
      expect(volunteer.deactivated_at).to_not be_nil
      expect(volunteer.deactivator_id).to eq(admin.id)
    end
  end

  context "#last_seen" do
    it "returns nil when the user has no survey response" do
      expect(user.last_seen).to be_nil
    end

    it "returns the updated time of the latest survey response " do
      create(:survey_response, volunteer: user, updated_at: DateTime.new(2021, 10, 15, 10, 35, 47))
      create(:survey_response, volunteer: user, updated_at: DateTime.new(2021, 10, 15, 11, 35, 47))

      expect(user.last_seen).to eq DateTime.new(2021, 10, 15, 11, 35, 47)
    end
  end

  context "#completed_surveys" do
    it "returns completed survey responses of the user" do
      completed1 = create(:survey_response, volunteer: user, status: :complete)
      create(:survey_response, volunteer: user)
      complted2 = create(:survey_response, volunteer: user, status: :complete)

      expect(user.completed_surveys).to match_array [completed1, complted2]
    end
  end
end
