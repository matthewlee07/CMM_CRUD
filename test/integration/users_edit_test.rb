require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

    def setup
        @user = users(:one)
        @user.save

        @user2 = users(:two)
        @user2.save
    end

    test "unsuccessful edit" do
        log_in_as(@user)
        get edit_user_path(@user)
        assert_template 'users/edit'
        patch user_path(@user), params: { user: { username:  "", email: "foo@invalid", password: "foo"} }
        assert_template 'users/edit'
    end

    test "successful edit" do
        log_in_as(@user)
        get edit_user_path(@user)
        assert_template 'users/edit'
        username  = "Foo Bar"
        email = "foo@bar.com"
        patch user_path(@user), params: { user: { username:  username, email: email, password: ""} }
        assert_not flash.empty?
        assert_redirected_to @user
        @user.reload
        assert_equal username.downcase,  @user.username
        assert_equal email, @user.email
    end

    test "successful edit with friendly forwarding" do
        get edit_user_path(@user)
        log_in_as(@user)
        assert_redirected_to root_path
        username  = "Foo Bar"
        email = "foo@bar.com"
        patch user_path(@user), params: { user: { username:  username, email: email, password: ""} }
        assert_not flash.empty?
        assert_redirected_to @user
        @user.reload
        assert_equal username.downcase,  @user.username
        assert_equal email, @user.email
    end
end