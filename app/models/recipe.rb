class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :instructions, presence: true

  accepts_nested_attributes_for :recipe_ingredients, :reject_if => proc {|attr| attr[:quantity].blank? && attr[:ingredient_attributes][:name].blank?}

  default_scope { order(name: :asc) }
end