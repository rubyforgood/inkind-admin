require "rails_helper"

RSpec.describe SupportTicket, type: :model do
  it "has valid factory" do
    expect(create(:support_ticket)).to be_valid
  end

  context "associations" do
    it { is_expected.to belong_to(:requestor).class_name("User") }
    it { is_expected.to belong_to(:closer).class_name("User").optional(true) }
    it { is_expected.to belong_to(:survey_response).optional(true) }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:description) }
  end

  context "enum" do
    it { is_expected.to define_enum_for(:status).with_values(active: 0, closed: 1) }
    it { is_expected.to define_enum_for(:category).with_values(survey_response: 0, admin: 1, contact_info: 2) }
  end

  context "#close!(user, notes)" do
    let(:user) { create(:user) }
    subject(:support_ticket) { create(:support_ticket) }

    it "returns false if the ticket is already closed" do
      expect(build(:support_ticket, status: :closed).close!(user, nil)).to be_falsey
    end

    it "updates ticket's status to closed" do
      support_ticket.close!(user, "Done")
      expect(support_ticket).to be_closed
    end

    it "updates ticket's closer" do
      support_ticket.close!(user, "Done")
      expect(support_ticket.closer).to eq user
    end

    it "updates ticket's closed_at" do
      freeze_time do
        support_ticket.close!(user, "Done")
        expect(support_ticket.closed_at).to eq Time.current
      end
    end

    it "updates ticket's closer_notes" do
      freeze_time do
        support_ticket.close!(user, "Done")
        expect(support_ticket.closer_notes).to eq "Done"
      end
    end
  end
end
