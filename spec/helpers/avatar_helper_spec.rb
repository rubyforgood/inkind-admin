require "rails_helper"

RSpec.describe FlashHelper, type: :helper do
  describe "#current_user_avatar_url" do
    it "is the gravatar url of the current logged user" do
      allow(helper).to receive(:current_user).and_return double(email: "test@test.com")

      expect(helper.current_user_avatar_url).to match %r{http://gravatar.com/avatar/[a-z0-9]+.png}
    end
  end
end
