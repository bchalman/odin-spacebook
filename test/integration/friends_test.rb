require 'test_helper'

class FriendsTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:ben)
    sign_in(@user)
  end

  test "friends page" do
    get friends_user_path(@user)
    assert_match @user.friends.count.to_s, response.body
    @user.friends.each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end
end
