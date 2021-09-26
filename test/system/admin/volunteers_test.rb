require "application_system_test_case"

class Admin::VolunteersTest < ApplicationSystemTestCase
  setup do
    @admin_volunteer = admin_volunteers(:one)
  end

  test "visiting the index" do
    visit admin_volunteers_url
    assert_selector "h1", text: "Admin/Volunteers"
  end

  test "creating a Volunteer" do
    visit admin_volunteers_url
    click_on "New Admin/Volunteer"

    click_on "Create Volunteer"

    assert_text "Volunteer was successfully created"
    click_on "Back"
  end

  test "updating a Volunteer" do
    visit admin_volunteers_url
    click_on "Edit", match: :first

    click_on "Update Volunteer"

    assert_text "Volunteer was successfully updated"
    click_on "Back"
  end

  test "destroying a Volunteer" do
    visit admin_volunteers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Volunteer was successfully destroyed"
  end
end
