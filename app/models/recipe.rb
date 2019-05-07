class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_many :comments, dependent: :destroy

  #Validations - special method calls that go in the model class and prevent them from being saved to the database if invalid
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :instructions, presence: true
  #Validate - custom validator for quick custom validations that you can extract later
  validate :validate_recipe_ingredients

  #lets you create and update related and child objects in one operation
  #rejects the row if the quantity and ingredient is blank
  accepts_nested_attributes_for :recipe_ingredients, reject_if: proc {|attr| attr[:quantity].blank? && attr[:ingredient_attributes][:name].blank?}

  #scoping - allows you to specify commonly-used queries which can be referenced as class method calls on the association/models
  #ActiveRecord Query Methods - ex. find, from, group, having, includes, limit, order, select, where
  scope :most_recent, -> (limit) { order("created_at desc").limit(limit) }
  scope :alphabetical_name, -> { order("name asc") }

  def validate_recipe_ingredients
    if recipe_ingredients.length < 1
      errors.add(:recipe_ingredients, "must have at least one quantity and ingredient listed")
    end
  end

  #creating 10 empty rows for recipe_ingredeints to help with the new/edit view
  def build_empty_ingredients
    10.times { recipe_ingredients.build.build_ingredient }
  end
end