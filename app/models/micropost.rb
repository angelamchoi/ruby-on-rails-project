class Micropost < ApplicationRecord
  belongs_to :user # A post belongs to a user
  validates :content, length: {maximum: 140} # validation        
end
