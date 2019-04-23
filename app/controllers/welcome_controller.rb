class WelcomeController < ApplicationController
  def new
    @recipes = Recipe.all.most_recent(5)
  end
end