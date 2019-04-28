class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  validates :quantity, presence: true
  validates :ingredient, presence: true
  validates :recipe, presence: true
  validate :validate_ingredient

  def ingredient_attributes=(ingredient_attributes)
    ingredient_attributes.values.each do |attribute|
      self.ingredient = Ingredient.find_or_initialize_by(name: attribute)
    end
  end

  def validate_ingredient
    if ingredient.nil? || ingredient.name.blank?
      errors.add(:ingredient, "must list one ingredient")
    end
  end
end