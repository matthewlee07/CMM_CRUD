require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
    def setup
        @project = projects(:one)
        @task = tasks(:one)
        @user = users(:one)
    end

    test "should be valid" do 
        assert @project.valid?
    end
    # field should be present
    test "project_name should be present" do 
        @project.project_name = " "
        assert_not @project.valid?
    end
    test "customer_id should be present" do 
        @project.customer_id = nil
        assert_not @project.valid?
    end 
    # field length validation
    test "project_name should not be too long" do
        @project.project_name = "a" * 51
        assert_not @project.valid?
    end
    #has_many destroy
    test "associated tasks should be destroyed" do 
        @project.tasks.create!(
        user_id: @user.id,
        task_name: @task.task_name
        )
        assert_difference 'Project.count', -1 do 
        @project.destroy
        end
    end
end
