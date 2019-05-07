class RecipesController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @recipe = Recipe.new(user_id: params[:user_id])
    @recipe.build_empty_ingredients
  end

  def create
    #create a brand new, unsaved, not-yet-validated Recipe object from the form.
    @recipe = current_user.recipes.build(recipe_params)
    #the recipe is saved if valid
    if @recipe.save
      flash[:message] = "Successfully created recipe"
      #returns a status_code of 302, which instructs the browswer to perform a NEW REQUEST!
      #(throw @recipe away and let the show action worry about re-reading it from the database)
      redirect_to recipe_path(@recipe)
    else
      #if the recipe is invalid, hold on to @recipe, because it is now full of useful error messages
      #and re-render the :new page, which knows how to display them alongside the user's entries.
      @recipe.build_empty_ingredients
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
    @recipe = Recipe.find(params[:id])
    @recipe.build_empty_ingredients
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update(recipe_params)
    flash[:message] = "Recipe updated"
    redirect_to recipe_path(@recipe)
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    flash[:message] = "Recipe deleted."
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

  def correct_user
    @recipe = Recipe.find_by(id: params[:id])
    if current_user != @recipe.user
      flash[:message] = "This recipe belongs to another user."
      redirect_to user_path(current_user)
    end
  end
end