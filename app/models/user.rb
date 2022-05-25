class User < ApplicationRecord
  before_save { email.downcase! }
  has_many :microposts
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 225},
                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
    end
end


# Notes
#--since a user has many posts we can show the relationship by --> has_many