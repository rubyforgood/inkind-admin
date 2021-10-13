require 'rails_helper'
require 'capybara/rspec'

describe "the edit organization form", type: :feature do
  it "updates the name of an organization" do
    stub_login
    organization = create(:organization, name: "Kurstyn's Dog and Baby Club")

    visit "/admin/organizations/#{organization.id}/edit"
    fill_in :organization_name, with: 'Steve and Erica\'s Chess Club'
    find('input[name="commit"]').click
    organization.reload

    expect(organization.name).to eq 'Steve and Erica\'s Chess Club'
  end

private

  def stub_login
    admin = create(:admin)

    visit new_user_session_path

    fill_in "Email", with: admin.email
    fill_in "Password", with: admin.password
    click_button "Log in"
  end
end