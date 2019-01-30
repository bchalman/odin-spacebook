require 'test_helper'

class CommentsTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:example_user)
    @post = posts(:one)
    sign_in(@user)
  end

  test "create should generate comment" do
    assert_difference 'Comment.count', 1 do
      post comments_path, params: { comment: { content: "test" }, post_id: @post.id }
    end
    assert_redirected_to root_path
  end

  test "create should post's commenters and commenter's posts_commented" do
    assert_difference ['@user.posts_commented.count', '@post.commenters.count'], 1 do
      post comments_path, params: { comment: { content: "test" }, post_id: @post.id }
    end
    assert_redirected_to root_path
  end

  test "destroy should delete comment" do
    @user.comments.create!(content: "test", post_id: @post.id)
    comment = @user.comments.find_by(post_id: @post.id)
    assert_difference 'Comment.count', -1 do
      delete comment_path(comment)
    end
    assert_redirected_to root_url
  end

end
