class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :body, presence: true
  validates :recipe_id, presence: true
  validates :user_id, presence: true

  scope :most_recent, -> { order("created_at desc") }
end