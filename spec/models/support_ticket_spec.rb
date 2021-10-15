require "rails_helper"

RSpec.describe SupportTicket, type: :model do
  it "has valid factory" do
    expect(create(:support_ticket)).to be_valid
  end

  context "#close!(user)" do
    let(:user) { create(:user) }
    subject(:support_ticket) { create(:support_ticket) }

    it "returns false if the ticket is already closed" do
      expect(build(:support_ticket, status: :closed).close!(user)).to be_falsey
    end

    it "udpates ticket's status to closed" do
      support_ticket.close!(user)
      expect(support_ticket).to be_closed
    end

    it "udpates ticket's closer" do
      support_ticket.close!(user)
      expect(support_ticket.closer).to eq user
    end

    it "udpates ticket's closed_at" do
      freeze_time do
        support_ticket.close!(user)
        expect(support_ticket.closed_at).to eq Time.current
      end
    end
  end
end
