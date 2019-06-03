function getAllRecipes() {
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