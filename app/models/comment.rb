class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :body, presence: true, allow_blank: false
  validates :recipe_id, presence: true
  validates :user_id, presence: true

  scope :most_recent, -> { order("created_at desc") }

  def self.comment_count
    if count == 0
      "This recipe has no comments."
    elsif count == 1
      "1 comment"
    else
      "#{count} comments"
    end
  end
end