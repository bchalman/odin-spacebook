require 'test_helper'

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:ben)
    @friend = users(:kim)
  end

  test "create should require logged in user" do
    assert_no_difference 'FriendRequest.count' do
      post friendships_path
    end
    assert_redirected_to new_user_session_path
  end

  test "delete should require logged in user" do
    assert_no_difference 'FriendRequest.count' do
      delete friendship_path(:one)
    end
    assert_redirected_to new_user_session_path
  end

end
