require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @user = users(:example_user)
    @post = @user.posts.build(content: "Test")
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "should require an author_id" do
    @post.author_id = nil
    assert_not @post.valid?
  end

  test "should require content" do
    @post.content = "   "
    assert_not @post.valid?
  end

  test "should be ordered by most recent first" do
    assert_equal posts(:most_recent), Post.first
  end

end
