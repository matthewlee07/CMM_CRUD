class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user
  validates :project_id, presence: true
  validates :user_id, presence: true
  validates :task_name, presence: true, length: { maximum: 500 }

  has_many :task_entries, dependent: :destroy
end
