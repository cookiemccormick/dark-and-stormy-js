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

    // for (let i = 0; i < recipe.comments.length; i++) {
    //   const comment = recipe.comments[i];

    //   this.comments.push(new Comment(comment));
    // }

    // this.comments = recipe.comments.map(function(comment) {
    //   return new Comment(comment);
    // })

    // for (let comment of recipe.comments) {
    //   this.comments.push(new Comment(comment));
    // }


    // let objects = [1,2,3];

    // for (let i = 0; i < objects.length; i++) {
    //   const object = objects[i];
    //   // do something with object
    // }
  }
}