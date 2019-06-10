class Recipe {
  constructor(recipe) {
    this.id = recipe.id;
    this.name = recipe.name;
    this.description = recipe.description;
    this.instructions = recipe.instructions;
    this.createdAt = new Date(recipe.created_at);
    this.user = new User(recipe.user);
    this.comments = recipe.comments.map(json => new Comment(json));
    this.ingredients = recipe.ingredients.map(json => new Ingredient(json));
  }
}