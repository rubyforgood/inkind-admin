require "application_system_test_case"

class Admin::SurveysTest < ApplicationSystemTestCase
  setup do
    @admin_survey = admin_surveys(:one)
  end

  test "visiting the index" do
    visit admin_surveys_url
    assert_selector "h1", text: "Admin/Surveys"
  end

  test "creating a Survey" do
    visit admin_surveys_url
    click_on "New Admin/Survey"

    click_on "Create Survey"

    assert_text "Survey was successfully created"
    click_on "Back"
  end

  test "updating a Survey" do
    visit admin_surveys_url
    click_on "Edit", match: :first

    click_on "Update Survey"

    assert_text "Survey was successfully updated"
    click_on "Back"
  end

  test "destroying a Survey" do
    visit admin_surveys_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Survey was successfully destroyed"
  end
end
