class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients
  has_many :ingredients, through: recipe_ingredients

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :instructions, presence: true
end