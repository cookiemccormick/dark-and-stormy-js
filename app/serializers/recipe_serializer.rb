class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :instructions, :created_at

  has_many :recipe_ingredients, key: :ingredients

  belongs_to :user
  has_many :comments

  def comments
    object.comments.order("created_at ASC")
  end
end