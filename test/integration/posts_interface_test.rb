require 'test_helper'

class PostsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:ben)
  end

  test "post interface" do
    sign_in(@user)
    get root_path
    assert_select 'div.pagination'
    # invalid submission
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: "" } }
    end
    assert_select 'div#error_explanation'
    # valid submission
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { content: "Test" } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match "Test", response.body
    # ensure likes are present in post view
    assert_select 'span', text: '0 likes'
    # ensure comments are present in post view
    assert_select 'li>span.content', text: 'Test'
    # delete post
    assert_select 'a', text: 'delete'
    first_post = @user.posts.paginate(page: 1).first
    assert_difference 'Post.count', -1 do
      delete post_path(first_post)
    end
    # Visit differnt user page, should be no delete links
    get user_path(users(:kim))
    assert_select 'a', text: 'delete', count: 0
  end
end
