class RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
    10.times {@recipe.recipe_ingredients.build.build_ingredient }
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      redirect_to recipes_path
    end
  end

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update(recipe_params)
    redirect_to recipe_path(@recipe)
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :name,
      :description,
      :instructions,
      recipe_ingredients_attributes: [
        :id,
        :quantity,
        ingredient_attributes: [
          :id,
          :name
        ]
      ]
    )
  end
end