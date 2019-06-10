class CommentsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      render json: @comment, status: 201
    else
      render json: @comment.errors.full_messages, status: 422
    end
  end

  def index
    if params[:recipe_id]
      @comments = Recipe.find(params[:recipe_id]).comments.most_recent
    else
      @comments = Comment.all.most_recent
    end
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @comments }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :recipe_id)
  end
end