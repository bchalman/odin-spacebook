require 'test_helper'

class LikesTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:example_user)
    @post = posts(:two)
    sign_in(@user)
  end

  test "should like normally" do
    assert_difference '@user.likes.count', 1 do
      post likes_path, params: { liked_post_id: @post.id }
    end
    assert_redirected_to root_path
  end

  test "should unlike normally" do
    @user.likes.create!(liked_post: @post)
    first_like = @user.likes.find_by(liked_post_id: @post.id)
    assert_difference '@user.likes.count', -1 do
      delete like_path(first_like)
    end
    assert_redirected_to root_path
  end
end
