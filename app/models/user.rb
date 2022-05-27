class User < ApplicationRecord
  has_many :microposts

  attr_accessor :remember_token, :activation_token
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 225 },
                    format: { with: VALID_EMAIL_REGEX},
                    uniqueness: true
  # has_secure_password
  # validates :password, presence: true, length: { minimum: 6 }
  # # Returns the hash digest of the given string
  # def User.digest(string)
  #   cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
  #                                                 BCrypt::Engine.cost
  #   BCrypt::Password.create(string, cost: cost)
  #   end
  # def create_activation_digest
  #   self.activation_token = User.new_token
  #   self.activation_digest = User.digest(activation_token)
  # end
end


# Notes
#--since a user has many posts we can show the relationship by --> has_many