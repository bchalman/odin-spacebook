require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:example_user)
  end

  test "index links" do
    sign_in @user
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
        assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end

end
