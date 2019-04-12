class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :instructions, null: false

      t.integer :user_id, null: false
      t.timestamps null: false
    end
  end
end