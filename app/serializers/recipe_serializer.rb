class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :description, :instructions, :user_id, :recipe_ingredients

  has_many :comments
end