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

  commentCountLabel() {
    let commentCount = null;

    if (this.comments.length === 0) {
      commentCount = "There are no comments.";
    } else if (this.comments.length === 1) {
      commentCount = "1 comment";
    } else {
      commentCount = `${this.comments.length} comments`;
    }
    return commentCount;
  }
}