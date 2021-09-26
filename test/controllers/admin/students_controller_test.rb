require "test_helper"

class Admin::StudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_student = admin_students(:one)
  end

  test "should get index" do
    get admin_students_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_student_url
    assert_response :success
  end

  test "should create admin_student" do
    assert_difference('Admin::Student.count') do
      post admin_students_url, params: { admin_student: {  } }
    end

    assert_redirected_to admin_student_url(Admin::Student.last)
  end

  test "should show admin_student" do
    get admin_student_url(@admin_student)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_student_url(@admin_student)
    assert_response :success
  end

  test "should update admin_student" do
    patch admin_student_url(@admin_student), params: { admin_student: {  } }
    assert_redirected_to admin_student_url(@admin_student)
  end

  test "should destroy admin_student" do
    assert_difference('Admin::Student.count', -1) do
      delete admin_student_url(@admin_student)
    end

    assert_redirected_to admin_students_url
  end
end
