class CommentsController < ApplicationController
  def new
    @recipe = Recipe.find(params[:recipe_id])
    @comment = Comment.new
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:message] = "Added comment"
      redirect_to comments_path
    else
      flash[:message] = "Comment box cannot be blank."
      redirect_to root_path
    end
  end

  def index
    if params[:recipe_id]
      @comments = Recipe.find(params[:recipe_id]).comments.most_recent
    else
      @comments = Comment.all.most_recent
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def destroy
    @comment = @recipe.comments.find(params[:id])
    if @comment.user_id == @current_user_id
      @comment.destroy
    end
    redirect_to recipe_path(@recipe)
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :recipe_id)
  end
end