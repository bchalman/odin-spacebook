require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "welcome_letter" do
    mail = UserMailer.welcome_letter(users(:example_user))
    assert_equal "Welcome to Spacebook!", mail.subject
    assert_equal ["exampleuser@example.com"], mail.to
    assert_equal ["noreply.spacebook@example.com"], mail.from
    assert_match "Welcome", mail.body.encoded
  end

end
