require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'Users.count' do
      post users_path, params: { user: { name: "", email: "user@invalid.com", password: "password", password_confirmation: "password"}}
    end
    follow_redirect!
    # assert_template 'users/show'
    # assert_not flash.FILL.IN
    # assert is_logged_in?
  end

end
