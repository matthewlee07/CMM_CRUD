class CreateTaskEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :task_entries do |t|
      t.references :task, foreign_key: true
      t.integer :duration
      t.text :note
      t.datetime :start_time

      t.timestamps
    end
  end
end
