require "rails_helper"

RSpec.describe MagicLinkMailer, type: :mailer do
  describe ".sign_in(user)" do
    let(:user) { double(:user, email: "user@example.com", token: "12345") }
    let(:mail) { MagicLinkMailer.sign_in(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Sign In to InKind App")
      expect(mail.to).to eq(["user@example.com"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "contains the link to the app" do
      expect(mail.body.encoded).to include("12345")
    end
  end
end
