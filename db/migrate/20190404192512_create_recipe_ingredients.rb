class CreateRecipeIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_ingredients do |t|
      t.integer :ingredient_id, null: false
      t.integer :recipe_id, null: false
      t.string: :quantity, null: false
      t.timestamps null: false
    end
  end
end