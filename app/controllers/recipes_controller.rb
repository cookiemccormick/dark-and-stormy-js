class RecipesController < ApplicationController
  def new
    @recipe = Recipe.new(user_id: params[:user_id])
    10.times { @recipe.recipe_ingredients.build.build_ingredient }
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      flash[:message] = "Successfully created recipe"
      redirect_to recipe_path(@recipe)
    else
      10.times { @recipe.recipe_ingredients.build.build_ingredient }
      render :new
    end
  end

  def index
    if params[:user_id]
      @recipes = User.find(params[:user_id]).recipes.alphabetical_name
    else
      @recipes = Recipe.all.alphabetical_name
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @comment = Comment.new
  end

  def edit
    if params[:user_id]
      user = User.find_by(id: params[:user_id])
      if user.nil?
        redirect_to users_path, alert: "User not found."
      else
        @recipe = user.recipes.find_by(id: params[:id])
        redirect_to user_recipes_path(user), alert: "Post not found." if @recipe.nil?
      end
    else
      @recipe = Recipe.find(params[:id])
    end
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
      :user_id,
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