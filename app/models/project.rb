class Project < ApplicationRecord
  belongs_to :customer
  validates :customer_id, presence: true
  validates :project_name, presence: true, length: { maximum: 50 }

  has_many :tasks, dependent: :destroy
end
