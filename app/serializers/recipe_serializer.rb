class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :description, :instructions, :user_id

  has_many :comments
end