class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_many :comments, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :instructions, presence: true
  validate :validate_recipe_ingredients

  accepts_nested_attributes_for :recipe_ingredients, reject_if: proc {|attr| attr[:quantity].blank? && attr[:ingredient_attributes][:name].blank?}

  scope :most_recent, -> (limit) { order("created_at desc").limit(limit) }
  scope :alphabetical_name, -> { order("name asc") }

  def validate_recipe_ingredients
    if recipe_ingredients.length < 1
      errors.add(:recipe_ingredients, "must have at least one quantity and ingredient listed")
    end
  end

  def build_empty_ingredients
    10.times { recipe_ingredients.build.build_ingredient }
  end
end