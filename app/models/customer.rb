class Customer < ApplicationRecord
  before_save :downcase_company

  validates :company, presence:true, length: {maximum: 50}, uniqueness: {case_sensitive: false}
  validates :address, presence:true, length: {maximum: 50}
  validates :city, presence:true, length: {maximum: 50}
  validates :state, presence:true, length: {maximum: 50}
  validates :zip, presence:true, length: {maximum: 50}

  has_many :projects, dependent: :destroy

  private

  def downcase_company
    self.company = company.downcase
  end
end
