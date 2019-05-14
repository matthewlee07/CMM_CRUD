require 'test_helper'

class TaskEntryTest < ActiveSupport::TestCase

    def setup 
        @task = tasks(:one)
        @task_entry = task_entries(:one)
        @task_entry.task_id = @task.id
    end

    test "should be valid" do 
        assert @task_entry.valid?
    end 
    # field should be present
    test "task_id should be present" do
        @task_entry.task_id = " "
        assert_not @task_entry.valid?
    end
    test "note should be present" do
        @task_entry.note = " "
        assert_not @task_entry.valid?
    end
    # field length validation
    test "note should not be too long" do
        @task_entry.note = "a" * 1001
        assert_not @task_entry.valid?
    end
    # time
    test "start_time should be set by fixtures" do 
        test_start_time = DateTime.parse("2019-04-20 17:06:13")
        assert @task_entry.start_time == test_start_time
    end
    test "duration should be calcualted correctly" do 
        @task_entry = TaskEntry.create!(
        task_id: @task.id,
        note: "This is a long note",
        start_time: DateTime.parse("2019-04-06 17:31:30"),
        updated_at: DateTime.parse("2019-04-06 18:31:30")
        )
        expected = 3600
        assert expected == @task_entry.updated_at - @task_entry.start_time
    end
end