require "test_helper"

class Admin::SurveysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_survey = admin_surveys(:one)
  end

  test "should get index" do
    get admin_surveys_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_survey_url
    assert_response :success
  end

  test "should create admin_survey" do
    assert_difference('Admin::Survey.count') do
      post admin_surveys_url, params: { admin_survey: {  } }
    end

    assert_redirected_to admin_survey_url(Admin::Survey.last)
  end

  test "should show admin_survey" do
    get admin_survey_url(@admin_survey)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_survey_url(@admin_survey)
    assert_response :success
  end

  test "should update admin_survey" do
    patch admin_survey_url(@admin_survey), params: { admin_survey: {  } }
    assert_redirected_to admin_survey_url(@admin_survey)
  end

  test "should destroy admin_survey" do
    assert_difference('Admin::Survey.count', -1) do
      delete admin_survey_url(@admin_survey)
    end

    assert_redirected_to admin_surveys_url
  end
end
