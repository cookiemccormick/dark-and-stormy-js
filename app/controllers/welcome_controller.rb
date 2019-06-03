class WelcomeController < ApplicationController
  def home
    @recipes = Recipe.all.most_recent(5)
    respond_to do |format|
      format.html { render :home }
      format.json { render json: @recipes }
    end
  end
end