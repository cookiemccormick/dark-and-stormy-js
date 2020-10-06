class RecipeIngredientSerializer < ActiveModel::Serializer
  attributes :quantity

  attribute(:name) {|o| o.object.ingredient.name }
  #Custom attribute for the ingredient name.

end