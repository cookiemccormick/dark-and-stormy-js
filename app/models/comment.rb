class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :body, presence: true, allow_blank: false
  validates :recipe_id, presence: true
  validates :user_id, presence: true
end