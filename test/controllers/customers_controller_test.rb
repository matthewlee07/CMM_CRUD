require 'test_helper'

class CustomersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @customer = customers(:one)
    @user = users(:one)
    @user.save
  end

  test "should get new" do
    log_in_as(@user)
    assert is_logged_in?
    get customers_new_path
    assert_response :success
  end
end
