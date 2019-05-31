class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :instructions

  has_many :recipe_ingredients, key: :ingredients

  belongs_to :user
  has_many :comments
end