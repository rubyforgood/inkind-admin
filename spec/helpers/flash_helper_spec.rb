require "rails_helper"

RSpec.describe FlashHelper, type: :helper do
  describe "#flash_banner" do
    it "handles notices with alert info" do
      expect(helper.flash_banner(:notice, "My Message")).to eql '<div class="alert notice alert-info">My Message</div>'
    end

    it "handles success with alert success" do
      expect(helper.flash_banner(:success, "My Message")).to eql '<div class="alert success alert-success">My Message</div>'
    end

    it "handles error with alert danger" do
      expect(helper.flash_banner(:error, "My Message")).to eql '<div class="alert error alert-danger">My Message</div>'
    end

    it "handles alert with alert warning" do
      expect(helper.flash_banner(:alert, "My Message")).to eql '<div class="alert alert alert-warning">My Message</div>'
    end
  end
end
