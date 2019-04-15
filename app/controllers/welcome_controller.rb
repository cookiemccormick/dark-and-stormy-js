class WelcomeController < ApplicationController
  def new
    @recipes = Recipe.all.order(:name)
  end
end