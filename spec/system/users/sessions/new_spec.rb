require "rails_helper"

RSpec.describe "sessions#new", type: :system do
  context "when volunteer with valid params" do
    it "signs in successfully" do
      volunteer = create(:volunteer)

      visit new_user_session_path

      fill_in "Email", with: volunteer.email
      fill_in "Password", with: volunteer.password
      click_button "Log in"

      expect(page).to have_text "Signed in successfully."
      expect(page).to have_selector("h1", text: "Volunteers Dashboard")
    end
  end

  context "when admin with valid params" do
    it "signs in successfully" do
      admin = create(:admin)

      visit new_user_session_path

      fill_in "Email", with: admin.email
      fill_in "Password", with: admin.password
      click_button "Log in"

      expect(page).to have_text "Signed in successfully."
      expect(page).to have_selector("h1", text: "Admin Dashboard")
    end
  end
end
