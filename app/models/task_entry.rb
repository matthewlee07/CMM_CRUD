class TaskEntry < ApplicationRecord
  belongs_to :task
  validates :task_id, presence: true
  validates :note, presence: true, length: { maximum: 1000 }
  validates :start_time, presence: true

  after_initialize :set_duration

  def updated_at=(value)
      self[:updated_at] = value
      set_duration
  end

  def start_time=(value)
      self[:start_time] = value
      set_duration
  end

  def set_duration()
      self[:duration] = calculate_duration
  end

  private
  def calculate_duration
      (updated_at && start_time) ? (updated_at - start_time).to_i : nil
  end
end