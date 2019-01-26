require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:example_user)
  end

  test "should redirect to login url when not logged in" do
    get user_path(@user)
    assert_redirected_to new_user_session_path
  end

  test "should redirect to home page when user logs in" do
    sign_in @user
    assert_redirected_to root_path
  end
end
