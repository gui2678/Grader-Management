require "test_helper"

class GraderApplicationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get grader_applications_index_url
    assert_response :success
  end

  test "should get show" do
    get grader_applications_show_url
    assert_response :success
  end

  test "should get new" do
    get grader_applications_new_url
    assert_response :success
  end

  test "should get create" do
    get grader_applications_create_url
    assert_response :success
  end

  test "should get edit" do
    get grader_applications_edit_url
    assert_response :success
  end

  test "should get update" do
    get grader_applications_update_url
    assert_response :success
  end

  test "should get destroy" do
    get grader_applications_destroy_url
    assert_response :success
  end
end
