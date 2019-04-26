require 'test_helper'

class TaskEntriesControllerTest < ActionDispatch::IntegrationTest
  def setup 
    @user = users(:one)
    @user.save
  end

  test "should get new" do 
    log_in_as(@user)
    assert is_logged_in?
    get new_task_path
    assert_response :success
  end
end
