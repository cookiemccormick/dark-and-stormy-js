function getAllRecipes() {
  if ($("#recipes").length === 0) {
    //Checks to see if we are on the recipes index view.
    return;
  }

  const userId = $("#recipes").attr("data-user-id");
  //If we are on the user recipes view - grab the id value from the data attribute
  const url = userId ? `/users/${userId}/recipes.json` : '/recipes.json';
  //We can request the list of recipes via a get request to '/users/${userId}/recipes.json'
    //or '/recipes.json' depending on whether the userId is present.

  $.get(url).done((data) => {
    //We start the AJAX GET request.  The first parameter is the URL.
      //The second parameter is the function that handles the response.
    //The callback that gets passed into .done gets data as an argument.
      //Data represents response returned from the API.
      //jQuery handles passing in the data object to the callbacks.
      //We tell jQuery that when it receives a response to pass it along to our
      //callbacks so they can handle accordingly.
    const recipes = data.map(json => new Recipe(json));
    //Create an array of recipe objects from an array of JSON objects

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
    //Checks to see if we are on the home view.
    return;
  }

  $.get('/home.json').done((data) => {
    //We start the AJAX GET request.  THe first parameter is the URL.
      //The second parameter is the function that handles the response.
    //The callback that gets passed into .done gets data as an argument.
      //Data represents response returned from the API.
      //jQuery handles passing in the data object to the callbacks.
      //We tell jQuery that when it receives a response to please pass it along to our
      //callbacks so they can handle accordingly.
     const recipes = data.map(json => new Recipe(json));
     //Create an array of recipe objects from an array of JSON objects

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
    //Checks to see if we are on the recipe show view.  Early exits if not on this page.
    return;
  }

  const recipeId = $("#showRecipeData").attr("data-id");
  //We grab that id value from the data attribute.

  $.get(`/recipes/${recipeId}.json`).done(loadRecipeData);
  //We start the AJAX GET request.  THe first parameter is the URL.
    //The second parameter is the function that handles the response.
    //In this case our callback function is a named function since it is shared.
}

$(showRecipe);

function nextRecipe() {
  event.preventDefault();

  $(".js-next").on("click", () => {
    let recipeId = $("#showRecipeData").attr("data-id");
    //We grab that id value from the data attribute.

    $.get(`/recipes/${recipeId}/next.json`).done((json) => {
      //Used the .get() method to make an AJAX request to our /recipes/:id/next route
        //using the id we stored in the data-id attribute.

      loadRecipeData(json);
      $("#showRecipeData").attr("data-id", json["id"]);
      //Updates data id attribute.
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

let currentRecipe = null;

function loadRecipeData(json) {
  const recipe = new Recipe(json);
  currentRecipe = recipe;
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

  $("#userRecipeLink").attr("href", `/users/${recipe.user.id}/recipes`);
  $("#userRecipeLink").html(`Recipes by ${recipe.user.name}`);
}

function setupCommentForm() {
  const form = $("#recipeCommentForm");

  form.submit((event) => {
    event.preventDefault();
    const recipeId = $("#showRecipeData").attr("data-id");
    //We grab that id value from the data attribute.

    const values = form.serialize();
    //Takes our form data and serializes it.

    const posting = $.post(`/recipes/${recipeId}/comments`, values);
    posting.done((data) => {
    //We're using posting object to specify what should happen when the AJAX request
      //is done.
    //Handle response.

      showRecipe();
    }).error((response) => {
      alert(response.responseJSON.join('\n'));
    });
  });
}