require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
    def setup 
        @project = projects(:one)
        @project.save
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
