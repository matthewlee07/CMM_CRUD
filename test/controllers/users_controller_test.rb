require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user1 = users(:one)
    @user2 = users(:two)
  end

  test "should get new" do
    get users_new_path
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
end