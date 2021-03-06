require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "password should be present" do
    @user.password = "   "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = 'a' * 250 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
     valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                          first.last@foo.jp alice+bob@baz.cn]
     valid_addresses.each do |valid_address|
       @user.email = valid_address
       assert @user.valid?, "#{valid_address.inspect} should be valid"
     end
   end

   test "email validation should reject invalid addresses" do
     invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                            foo@bar_baz.com foo@bar+baz.com]
     invalid_addresses.each do |invalid_address|
       @user.email = invalid_address
       assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
     end
   end

   test "email addresses should be unique" do
     duplicate_user = @user.dup
     duplicate_user.email = @user.email.upcase
     @user.save
     assert_not duplicate_user.valid?
   end

   test "email addresses should be saved as lower-case" do
     mixed_case_email = "Foo@ExAMPle.CoM"
     @user.email = mixed_case_email
     @user.save
     assert_equal mixed_case_email.downcase, @user.reload.email
   end

   test "password should be present (nonblank)" do
     @user.password = @user.password_confirmation = " " * 6
     assert_not @user.valid?
   end

   test "password should have a minimum length" do
     @user.password = @user.password_confirmation = "a" * 5
     assert_not @user.valid?
   end

   test "associated posts should be destroyed with user" do
     @user.save
     @user.posts.create!(content: "test")
     assert_difference 'Post.count', -1 do
       @user.destroy
     end
   end

   test "associated likes should be destroyed with user" do
     @user.save
     @user.likes.create!(liked_post: posts(:one))
     assert_difference 'Like.count', -1 do
       @user.destroy
     end
   end

   test "feed should only contain posts from friends" do
     ben = users(:ben)
     kim = users(:kim)
     kim.friends<<ben
     user_1 = users(:user_1)
     # posts from friends
     ben.posts.each do |post|
       assert kim.feed.include?(post)
     end
     # posts from self
     ben.posts.each do |post|
       assert ben.feed.include?(post)
     end
     # posts from non-friend
     ben.posts.each do |post|
       assert_not user_1.feed.include?(post)
     end
   end

end
