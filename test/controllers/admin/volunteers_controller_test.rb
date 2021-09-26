require "test_helper"

class Admin::VolunteersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_volunteer = admin_volunteers(:one)
  end

  test "should get index" do
    get admin_volunteers_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_volunteer_url
    assert_response :success
  end

  test "should create admin_volunteer" do
    assert_difference('Admin::Volunteer.count') do
      post admin_volunteers_url, params: { admin_volunteer: {  } }
    end

    assert_redirected_to admin_volunteer_url(Admin::Volunteer.last)
  end

  test "should show admin_volunteer" do
    get admin_volunteer_url(@admin_volunteer)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_volunteer_url(@admin_volunteer)
    assert_response :success
  end

  test "should update admin_volunteer" do
    patch admin_volunteer_url(@admin_volunteer), params: { admin_volunteer: {  } }
    assert_redirected_to admin_volunteer_url(@admin_volunteer)
  end

  test "should destroy admin_volunteer" do
    assert_difference('Admin::Volunteer.count', -1) do
      delete admin_volunteer_url(@admin_volunteer)
    end

    assert_redirected_to admin_volunteers_url
  end
end
