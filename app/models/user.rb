class User < ApplicationRecord
  has_many :microposts, dependent: :destroy # if user is destroyed then post is also destroyed
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:    :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy                                
  has_many :following, through: :active_relationships, source: :followed
  has_many :following, through: :passive_relationships, source: :follower


  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 225 },
                    format: { with: VALID_EMAIL_REGEX},
                    uniqueness: true
  def feed
    part_of_feed = "relationships.follower_id = :id or microposts.user_id = :id"
    Micropost.left_outer_joins(user: :followers)
             .where(part_of_feed, { id: id }).distinct
             .includes(:user, image_attachment: :blob)
  end

  # follows a user
  def follow(other_user)
    following << other_user unless self == other_user
  end

  # unfollows a user
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returrns true if the current user is following the other user
  def following?(other_user)
    following.include?(other_user)
  end
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