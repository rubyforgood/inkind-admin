require "rails_helper"

RSpec.describe VolunteerApp do
  describe ".magic_link(user)" do
    it "generates a magic link for the user in the volunteer app" do
      user = double(token: 'my-token')

      magic_link = VolunteerApp.magic_link(user)

      expect(magic_link).to start_with Rails.application.config.volunteer_app_url
      expect(magic_link).to end_with "?token=my-token"
    end
  end
end
