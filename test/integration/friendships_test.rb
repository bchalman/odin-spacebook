require 'test_helper'

class FriendshipsTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:ben)
    @friend = users(:kim)
    sign_in(@user)
  end

  test "create should build two-way relationship" do
    assert_difference 'Friendship.count', 2 do
      post friendships_path, params: {friend_id: @friend.id}
    end
    assert_redirected_to @friend
  end

  test "create should update each user's friends" do
    assert_difference ['@user.friends.count', '@friend.friends.count'], 1 do
      post friendships_path, params: {friend_id: @friend.id}
    end
    assert_redirected_to @friend
  end

  test "destroy should delete relationship" do
    @user.accept_friend_request_from(@friend)
    friendship = @user.friendships.find_by(friend_id: @friend.id)
    assert_difference 'Friendship.count', -2 do
      delete friendship_path(friendship)
    end
    assert_redirected_to @friend
  end
end
