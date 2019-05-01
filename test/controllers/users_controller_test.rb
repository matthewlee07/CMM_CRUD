require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
    def setup
        @user1 = users(:one)
        @user2 = users(:two)
    end

    test "should get new" do
        get new_user_path
        assert_response :success
    end

    test "should redirect edit when not logged in" do
        get edit_user_path(@user1)
        assert_not flash.empty?
        assert_redirected_to login_url
    end

    test "should redirect update when not logged in" do
        patch user_path(@user1), params: { user1: { username: @user1.username, email: @user1.email } }
        assert_not flash.empty?
        assert_redirected_to login_url
    end

    test "should redirect index when not logged in" do
        get users_path
        assert_redirected_to login_url
    end

    test "should redirect destroy when not logged in" do
        assert_no_difference 'User.count' do
            delete user_path(@user1)
        end
        assert_redirected_to login_url
    end

    test "should redirect destroy when logged in as a non-admin" do
        log_in_as(@user2)
        assert_no_difference 'User.count' do
        delete user_path(@user1)
        end
        assert_redirected_to login_url
    end
end