class Recipe {
  constructor(recipe) {
    this.id = recipe.id;
    this.name = recipe.name;
    this.description = recipe.description;
    this.instructions = recipe.instructions;
    this.createdAt = new Date(recipe.created_at);
    //Taking the created_at string and making a Date object.

    this.user = new User(recipe.user);
    //Creating a user instance from the user JSON.

    this.comments = recipe.comments.map(json => new Comment(json));
    //Creating comment instances from the comment JSON.

    this.ingredients = recipe.ingredients.map(json => new Ingredient(json));
    //Creating ingredient instances from the ingredient JSON.
  }

  commentCountLabel() {
    //no longer write the word function when defining a method on a JavaScript class
    //instance method for comments

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