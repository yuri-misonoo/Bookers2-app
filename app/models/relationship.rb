class Relationship < ApplicationRecord
  
  belongs_to :user
  belongs_to :follow, class_name: 'User'
  
  validates :user_id, presance: true
  validates :follow_id, presance: true
  
end
