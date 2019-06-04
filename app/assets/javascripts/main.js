function getAllRecipes() {
  if ($("#recipes").length === 0) {
    return;
  }

  $.get('/recipes.json').done(function(data) {
    const recipes = data.map(json => new Recipe(json));

    if (recipes.length === 0) {
      $("#recipes").html("<p>There are currently no recipes.</p>");
      return;
    }

    const recipeList = recipes.map(function(recipe) {
      return `
      <li>
        <a href="/recipes/${recipe.id}">${recipe.name}</a>
        created ${recipe.createdAt.toLocaleDateString()}<br>
        ${recipe.description}<br>
        by <a href="/users/${recipe.user.id}">${recipe.user.name}</a><br><br>
      </li>`;
    })

    $("#recipes").html(`<ul>${recipeList.join('')}</ul>`);
  });
}

$(getAllRecipes);

function getRecentRecipes() {
  if ($("#recentRecipes").length === 0) {
    return;
  }

  $.get('/home.json').done(function(data) {
    const recipes = data.map(json => new Recipe(json));

    if (recipes.length === 0) {
      $("#recentRecipes").html("<p>There are currently no recipes.</p>");
      return;
    }

    const recipeList = recipes.map(function(recipe) {
      return `
      <li>
        <a href="/recipes/${recipe.id}">${recipe.name}</a> -
        created ${recipe.createdAt.toLocaleDateString()}
        by ${recipe.user.name}
      </li>`;
    })

    $("#recentRecipes").html(`<ul>${recipeList.join('')}</ul>`);
  });
}

$(getRecentRecipes);

function showRecipe() {
  if ($("#showRecipeData").length === 0) {
    return;
  }

  const recipeId = $("#showRecipeData").attr("data-id");

  $.get(`/recipes/${recipeId}.json`).done(function(json) {
    const recipe = new Recipe(json);

    const recipeIngredients = recipe.ingredients.map(function(ingredient) {
      return `
      <tr>
        <td>${ingredient.quantity}</td>
        <td>${ingredient.name}</td>
      </tr>`;
    });

    let commentCount = null;

    if (recipe.comments.length === 0) {
      commentCount = "<p>There are no comments.</p>";
    } else if (recipe.comments.length === 1) {
      commentCount = "<p>1 comment</p>";
    } else {
      commentCount = `<p>${recipe.comments.length} comment</p>`;
    }

    const comments = recipe.comments.map(function(comment) {
      return `
      <li>
        ${comment.body} created on ${comment.createdAt.toLocaleDateString()} by ${comment.commenter}
      </li>`;
    })

    const html = `
      <h1>${recipe.name}</h1>
      <h4>Created ${recipe.createdAt.toLocaleDateString()}<br> by <a href="/${recipe.user.name}/${recipe.user.id}">${recipe.user.name}</a></h4>
      <h3>About the ${recipe.name} cocktail</h3>
      <p>${recipe.description}</p>
      <h3>Ingredients in the ${recipe.name} cocktail</h3>
      <table>
        <thead>
          <tr>
            <th>Quantity</th>
            <th>Ingredients</th>
          </tr>
        </thead>

        <tbody>
          ${recipeIngredients.join('')}
        </tbody>
      </table>

      <h3>How to make the ${recipe.name} cocktail</h3>
      <p>${recipe.instructions}</p>

      <h3>Comments:</h3>
      <div>${commentCount}</div><br>
      <div>${comments}</div><br>`;

    $("#showRecipeData").html(html);
  });
}

$(showRecipe);