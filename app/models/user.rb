require 'uri'

class User < ApplicationRecord
  before_save :downcase_email, :downcase_username

  validates :username, presence: true, length: {maximum: 50}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {maximum:50, minimum: 7}, allow_nil: true
  validates :email, presence:true, length: { maximum: 255 }, format:{ with: URI::MailTo::EMAIL_REGEXP}, uniqueness: { case_sensitive: false }

  has_secure_password

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  private

    def downcase_email
      self.email = email.downcase
    end

    def downcase_username
      self.username = username.downcase
    end
end
