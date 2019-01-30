require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @post = posts(:one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: "Test" } }
    end
    assert_redirected_to new_user_session_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    assert_redirected_to new_user_session_path
  end

  test "should redirect show when not logged in" do
    get post_path(@post)
    assert_redirected_to new_user_session_path
  end

  test "should redirect destroy for other user's post" do
    sign_in(users(:kim))
    post = posts(:one)
    assert_no_difference 'Post.count' do
      delete post_path(post)
    end
    assert_redirected_to root_url
  end

end
