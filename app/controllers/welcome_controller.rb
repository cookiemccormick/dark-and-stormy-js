class WelcomeController < ApplicationController
  def new
    @recipes = Recipe.all
  end
end