require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  
    def setup 
        @project = projects(:one)
        @user = users(:one)
        @user.save
    end

    test "should get new" do 
        log_in_as(@user)
        assert is_logged_in?
        get new_project_path
        assert_response :success
    end
end
