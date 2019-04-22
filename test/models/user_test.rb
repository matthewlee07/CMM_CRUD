require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = users(:one)
    @task = tasks(:one)
    @project = projects(:one)
  end

  test "should be valid" do 
    assert @user.valid?
  end
  # field should be present
  test "username should be present" do
    @user.username = " " 
    assert_not @user.valid?
  end
  test "password should be present" do
    @user.password = " " 
    assert_not @user.valid?
  end
  test "email should be present" do
    @user.email = " " * 7
    assert_not @user.valid?
  end
  # field length validation
  test "name should not be too long" do
    @user.username = "a" * 51
    assert_not @user.valid?
  end
  test "password should not be too long" do
    @user.password = "a" * 51
    assert_not @user.valid?
  end
  test "password should not be too short" do
    @user.password = "a" * 6
    assert_not @user.valid?
  end
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  # email format validation
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
  # field should be unique
  test "username should be unique" do
    duplicate_user = @user.dup
    duplicate_user.username = @user.username.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  # field should be saved as lower-case 
  test "username should be saved as lower-case" do
    mixed_case_username = "FoO"
    @user.username = mixed_case_username
    @user.save
    assert_equal mixed_case_username.downcase, @user.reload.username
  end
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  # has_many destroy
  test "associated tasks should be destroyed" do 
    @user.tasks.create!(
      task_name: @task.task_name, 
      project_id: @project.id
    )
    assert_difference 'User.count', -1 do 
      @user.destroy
    end
  end
  # authentication
  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end
end
