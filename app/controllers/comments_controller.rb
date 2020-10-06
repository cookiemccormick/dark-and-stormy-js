class CommentsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      render json: @comment, status: 201
      #201 created.

    else
      render json: @comment.errors.full_messages, status: 422
      #422 unprocessable entity.

    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :recipe_id)
  end
end