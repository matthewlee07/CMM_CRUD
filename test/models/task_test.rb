require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  def setup
    @task = tasks(:one)
    @task_entry = task_entries(:one)
    @task_entry.save
  end

  test "should be valid" do 
    assert @task.valid?
  end
  # field should be present
  test "project_id should be present" do 
    @task.project_id = " "
    assert_not @task.valid?
  end 
  test "user_id should be present" do 
    @task.user_id = " "
    assert_not @task.valid?
  end
  test "task_name should be present" do 
    @task.task_name = " "
    assert_not @task.valid?
  end
  # field length validation
  test "task name should not be too long" do
    @task.task_name = "a" * 51
    assert_not @task.valid?
  end
  # has_many destroy
  test "associated task_entries should be destroyed" do 
    @task.task_entries.create!(
        note: @task_entry.note,
        start_time: @task_entry.start_time)
    assert_difference 'Task.count', -1 do 
        @task.destroy 
    end 
  end
end
