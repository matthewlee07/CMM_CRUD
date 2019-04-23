require 'uri'

class User < ApplicationRecord
  attr_accessor :remember_token

  before_save :downcase_email, :downcase_username
  validates :username, presence: true, length: {maximum: 50}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {maximum:50, minimum: 7}, allow_nil: true
  validates :email, presence:true, length: { maximum: 255 }, format:{ with: URI::MailTo::EMAIL_REGEXP}, uniqueness: { case_sensitive: false }

  has_secure_password
  has_many :tasks, dependent: :destroy

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def downcase_username
    self.username = username.downcase
  end
end
