require 'test_helper'

class LikeTest < ActiveSupport::TestCase

  def setup
    @like = likes(:one)
  end

  test "should be valid" do
    assert @like.valid?
  end

  test "should require a liker_id" do
    @like.liker_id = nil
    assert_not @like.valid?
  end

  test "should require a liked_post_id" do
    @like.liked_post_id = nil
    assert_not @like.valid?
  end

end
