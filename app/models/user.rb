class User < ApplicationRecord
  has_many :microposts
  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 225}

end


# Notes
#--since a user has many posts we can show the relationship by --> has_many