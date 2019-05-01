require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

    test "invalid user signup information" do
        get new_user_path
        assert_no_difference 'User.count' do
        post users_path, params: { user: { username:  ""} }
        end
        assert_template 'users/new'
    end

    test "valid user signup information" do
      get new_user_path
      assert_difference 'User.count', 1 do
        post users_path, params: { user: { 
          username:  "Example User", 
          email: "user@example.com", 
          password: "password"} }
      end
      follow_redirect!
      assert_template root_path
      assert is_logged_in?
    end
end