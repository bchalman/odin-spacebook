require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def setup
    @user = users(:example_user)
    @comment = @user.comments.build(content: "Test", post: posts(:one))
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "should require content" do
    @comment.content = ""
    assert_not @comment.valid?
  end

  test "should require post" do
    @comment.post_id = nil
    assert_not @comment.valid?
  end

  test "should require author" do
    @comment.author_id = nil
    assert_not @comment.valid?
  end

end
