class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :comment, presence: true
  validates :rating, presence: true

  default_scope order("created_at desc")
end