class RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
    10.times {@recipe.recipe_ingredients.build.build_ingredient }
  end

  def create
    @user = current_user
    @recipe = @user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      redirect to recipes_path
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

  private

  def recipe_params
    params.require(:recipe).permit(
      :name,
      :description,
      :instructions,
      recipe_ingredients_attributes: [
        :quantity,
        ingredient_attributes: [
          :name
        ]
      ]
    )
  end
end