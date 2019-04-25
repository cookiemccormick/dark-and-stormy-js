class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :comments, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :instructions, presence: true

  accepts_nested_attributes_for :recipe_ingredients, :reject_if => proc {|attr| attr[:quantity].blank? && attr[:ingredient_attributes][:name].blank?}

  scope :most_recent, -> (limit) { order("created_at desc").limit(limit) }
  scope :alphabetical_name, -> { order("name asc") }
end