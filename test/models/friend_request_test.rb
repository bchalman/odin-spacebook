require 'test_helper'

class FriendRequestTest < ActiveSupport::TestCase
  def setup
    @friend_request = FriendRequest.new(sender_id: users(:example_user).id,
                                        recipient_id: users(:ben).id)
  end

  test "should be valid" do
    assert @friend_request.valid?
  end

  test "should require a sender_id" do
    @friend_request.sender_id = nil
    assert_not @friend_request.valid?
  end

  test "should require a recipient_id" do
    @friend_request.recipient_id = nil
    assert_not @friend_request.valid?
  end
end
