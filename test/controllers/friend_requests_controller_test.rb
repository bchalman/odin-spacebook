require 'test_helper'

class FriendRequestControllerTest < ActionDispatch::IntegrationTest

  def setup
    @sender = users(:ben)
    @recipient = users(:kim)
  end

  test "create should require logged in user" do
    assert_no_difference 'FriendRequest.count' do
      post friend_requests_path
    end
    assert_redirected_to new_user_session_path
  end

  test "delete should require logged in user" do
    assert_no_difference 'FriendRequest.count' do
      delete friend_request_path(:one)
    end
    assert_redirected_to new_user_session_path
  end

end
