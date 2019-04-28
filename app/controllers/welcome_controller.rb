class WelcomeController < ApplicationController
  def home
    @recipes = Recipe.all.most_recent(5)
  end
end