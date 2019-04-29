# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
  Used the Rails gem ~> 5.2.3.
- [x] Include at least one has_many relationship (x has_many y; e.g. User has_many Recipes)
  - There are 7 has_many relationships in this application:
    recipe has_many ingredients through recipe_ingredients
    ingredients has_many recipes through recipe_ingredients
    user has_many recipes
    recipe has_many recipe_ingredients
    ingredients has_many recipe_ingredients
    user has_many comments
    recipe has_many comments
- [x] Include at least one belongs_to relationship (x belongs_to y; e.g. Post belongs_to User)
  - There are 5 belongs_to relations in this application:
    recipe belongs_to user
    recipe_ingredients belongs_to recipe
    recipe_ingredients belongs_to ingredient
    comment belongs_to user
    comment belongs_to recipe
- [x] Include at least two has_many through relationships (x has_many y through z; e.g. Recipe has_many Items through Ingredients)
  - There are 2 has_many through relationships in this application:
    recipe has_many ingredients through recipe_ingredients
    ingredients has_many recipes through recipe_ingredients
- [x] Include at least one many-to-many relationship (x has_many y through z, y has_many x through z; e.g. Recipe has_many Items through Ingredients, Item has_many Recipes through Ingredients)
  - There is one many-to-many relationship in this application:
    Recipe has_many ingredients through recipe_ingredients, ingredients has_many recipes through recipe_ingredients.
- [x] The "through" part of the has_many through includes at least one user submittable attribute,
that is to say, some attribute other than its foreign keys that can be submitted by the app's user (attribute_name e.g. ingredients.quantity)
  - The user is able to submit the quantity for the recipe_ingredients model.
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
  - user Model
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, unless: :uid?
  - recipe Model
    validates :name, presence: true, uniqueness: true
    validates :description, presence: true
    validates :instructions, presence: true
    validate :validate_recipe_ingredients
  - ingredient Model
    validates :name, presence: true, uniqueness: true
  - comment Model
    validates :body, presence: true, allow_blank: false
    validates :recipe_id, presence: true
    validates :user_id, presence: true
  - recipe_ingredient model
    validates :quantity, presence: true
    validates :ingredient, presence: true
    validates :recipe, presence: true
    validate :validate_ingredient
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
  - comment model
    scope :most_recent, localhost:3000/recipes/7/comments/new
    scope :comment_count, localhost:3000/recipes/4
  - recipe model
    scope :most_recent, localhost:3000/home
    scope :alphabetical_name, localhost:3000/recipes
  - user model
    scope :alphabetical_name, localhost:3000/users
- [x] Include signup (how e.g. Devise)
  Used the bcrypt gem.
- [x] Include login (how e.g. Devise)
  Used the bcrypt gem.
- [x] Include logout (how e.g. Devise)
  Used the bcrypt gem.
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
  Users have the option of signing up through OmniAuth Facebook.
- [x] Include nested resource show or index (URL e.g. users/2/recipes)
  users/4/recipes
  recipes/2/comments
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients/new)
  recipes/1/comments/new
- [x] Include form display of validation errors (form URL e.g. /recipes/new)
  /recipes/new
  /recipes/6/comments/new
  /signup

Confirm:
- [x] The application is pretty DRY
  Created helper methods and scopes to be re-used in the application.
- [x] Limited logic in controllers
  Logic methods have been written in the models.
- [x] Views use helper methods if appropriate
  Views access the current_user helper method.
- [x] Views use partials if appropriate
  Recipe new and edit forms render _form.html.erb.