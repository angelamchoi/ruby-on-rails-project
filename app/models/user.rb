class User < ApplicationRecord
  has_many :microposts
end


# Notes
#--since a user has many posts we can show the relationship by --> has_many