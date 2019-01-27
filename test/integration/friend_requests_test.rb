require 'test_helper'

class FriendRequestsTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:example_user)
    @other = users(:kim)
    sign_in(@user)
  end

  test "should send request normally" do
    assert_difference ['@user.requested_friends.count', '@other.requesting_friends.count'], 1 do
      post friend_requests_path, params: { recipient_id: @other.id }
    end
    assert_redirected_to @other
  end

  test "should delete request normally" do
    @user.send_friend_request_to(@other)
    request = @user.sent_friend_requests.find_by(recipient_id: @other.id)
    assert_difference ['@user.requested_friends.count', '@other.requesting_friends.count'], -1 do
      delete friend_request_path(request)
    end
    assert_redirected_to @other
  end

end
