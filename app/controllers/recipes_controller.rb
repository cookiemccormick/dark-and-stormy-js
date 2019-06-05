class RecipesController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @recipe = Recipe.new(user_id: params[:user_id])
    @recipe.build_empty_ingredients
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      flash[:message] = "Successfully created recipe"
      redirect_to recipe_path(@recipe)
    else
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
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @recipes }
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @comment = Comment.new
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @recipe }
    end
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

  def next
    render json: Recipe.find(params[:id]).next
  end

  def previous
    render json: Recipe.find(params[:id]).previous
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