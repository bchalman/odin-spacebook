require 'test_helper'

class UsersControllerControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:example_user)
  end

  test "should redirect show and index if not logged in" do
    get user_path(@user)
    assert_redirected_to new_user_session_path
    get users_path
    assert_redirected_to new_user_session_path
  end

  test "should get new" do
    get new_user_registration_path
    assert_response :success
  end

  test "should redirect friends when not logged in" do
    get friends_user_path(@user)
    assert_redirected_to new_user_session_path
  end

end
