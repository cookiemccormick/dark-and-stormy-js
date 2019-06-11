function getAllRecipes() {
  if ($("#recipes").length === 0) {
    return;
  }

  const userId = $("#recipes").attr("data-user-id");
  const url = userId ? `/users/${userId}/recipes.json` : '/recipes.json';

  $.get(url).done((data) => {
    const recipes = data.map(json => new Recipe(json));

    if (recipes.length === 0) {
      $("#recipes").html("<p>There are currently no recipes.</p>");
      return;
    }

    const recipeList = recipes.map((recipe) => {
      return `
        <li>
          <a href="/recipes/${recipe.id}">${recipe.name}</a>
          created ${recipe.createdAt.toLocaleDateString()}<br>
          ${recipe.description}<br>
          by <a href="/users/${recipe.user.id}">${recipe.user.name}</a><br><br>
        </li>
      `;
    })

    $("#recipes").html(`<ul>${recipeList.join('')}</ul>`);
  });
}

$(getAllRecipes);

function getRecentRecipes() {
  if ($("#recentRecipes").length === 0) {
    return;
  }

  $.get('/home.json').done((data) => {
    const recipes = data.map(json => new Recipe(json));

    if (recipes.length === 0) {
      $("#recentRecipes").html("<p>There are currently no recipes.</p>");
      return;
    }

    const recipeList = recipes.map((recipe) => {
      return `
        <li>
          <a href="/recipes/${recipe.id}">${recipe.name}</a> -
          created ${recipe.createdAt.toLocaleDateString()}
          by ${recipe.user.name}
        </li>
      `;
    });

    $("#recentRecipes").html(`<ul>${recipeList.join('')}</ul>`);
  });
}

$(getRecentRecipes);

function showRecipe() {
  if ($("#showRecipeData").length === 0) {
    return;
  }

  const recipeId = $("#showRecipeData").attr("data-id");

  $.get(`/recipes/${recipeId}.json`).done(loadRecipeData);
}

$(showRecipe);

function nextRecipe() {
  event.preventDefault();
  $(".js-next").on("click", () => {
    let recipeId = $("#showRecipeData").attr("data-id");
    $.get(`/recipes/${recipeId}/next.json`).done((json) => {
      loadRecipeData(json);
      $("#showRecipeData").attr("data-id", json["id"]);
    });
  });
}

$(nextRecipe);

function previousRecipe() {
  event.preventDefault();
  $(".js-prev").on("click", () => {
    let recipeId = $("#showRecipeData").attr("data-id");
    $.get(`/recipes/${recipeId}/previous.json`).done((json) => {
      loadRecipeData(json);
      $("#showRecipeData").attr("data-id", json["id"]);
    });
  });
}

$(previousRecipe);

function loadRecipeData(json) {
  const recipe = new Recipe(json);

  const recipeIngredients = recipe.ingredients.map((ingredient) => {
    return `
      <tr>
        <td>${ingredient.quantity}</td>
        <td>${ingredient.name}</td>
      </tr>
    `;
  });

  const comments = recipe.comments.map((comment) => {
    return `
      <li>
        ${comment.commenter} - ${comment.createdAt.toLocaleDateString()} - ${comment.body}
      </li>
    `;
  })

  const html = `
    <h1>${recipe.name}</h1>
    <h4>Created ${recipe.createdAt.toLocaleDateString()}<br> by
      <a href="/users/${recipe.user.id}">${recipe.user.name}</a></h4>
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

    <div>
      <p>${recipe.commentCountLabel()}</p>
    </div>

    <div><ul id="commentList">${comments.join('')}</ul></div><br>

    <form id="recipeCommentForm">
      <textarea name="comment[body]" id="comment_body"></textarea><br><br>
      <input type="submit" name="commit" value="Add Comment"><br><br>
    </form>
  `;

  $("#showRecipeData").html(html);
  setupCommentForm();
}

function setupCommentForm() {
  const form = $("#recipeCommentForm");

  form.submit((event) => {
    event.preventDefault();

    const recipeId = $("#showRecipeData").attr("data-id");
    const values = form.serialize();
    const posting = $.post(`/recipes/${recipeId}/comments`, values);

    posting.done((data) => {
      showRecipe();
    }).error((response) => {
      alert(response.responseJSON.join('\n'));
    });
  });
}