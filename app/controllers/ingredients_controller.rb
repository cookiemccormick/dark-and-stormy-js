class IngredientsController < ApplicationController
  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      redirect_to ingredient_path(@ingredient)
    else
      redirect_to ingredients_path
    end
  end

  def index
    if params[:recipe_id]
      @ingredients = Recipe.find(params[:recipe_id]).ingredients
    else
      @ingredients = Ingredient.all
    end
  end

  def show
    @ingredient = Ingredient.find(params[:id])
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    @ingredient.update(ingredient_params)
    redirect_to ingredient_path(@ingredient)
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name)
  end
end