require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @comment = comments(:one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Comment.count' do
      post comments_path, params: { comment: { content: "Test" } }
    end
    assert_redirected_to new_user_session_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Comment.count' do
      delete comment_path(@comment)
    end
    assert_redirected_to new_user_session_path
  end

  test "should redirect destroy for other user's post" do
    sign_in(users(:kim))
    comment = comments(:one)
    assert_no_difference 'Comment.count' do
      delete comment_path(comment)
    end
    assert_redirected_to root_url
  end
end
