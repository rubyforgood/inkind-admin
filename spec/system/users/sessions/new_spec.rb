require "rails_helper"

RSpec.describe "sessions#new", type: :system do
  context "when password is expired" do
    it "requires a password update" do
      volunteer = create(:volunteer)
      volunteer.need_change_password!

      visit new_user_session_path

      fill_in "Email", with: volunteer.email
      fill_in "Password", with: volunteer.password
      click_button "Log in"

      expect(page).to have_text "Your password is expired. Please renew your password."
    end
  end

  context "when volunteer with valid params" do
    it "signs in successfully" do
      volunteer = create(:volunteer)

      visit new_user_session_path

      fill_in "Email", with: volunteer.email
      fill_in "Password", with: volunteer.password
      click_button "Log in"

      expect(page).to have_text "Signed in successfully."
      expect(page).to have_selector("h3", text: "Volunteer Home")
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
      expect(page).to have_selector("h3", text: "Admin Home")
    end
  end
end
