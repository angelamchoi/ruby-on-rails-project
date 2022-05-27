class Micropost < ApplicationRecord
  belongs_to :user # A post belongs to a user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, length: {maximum: 140} # validation        
end
