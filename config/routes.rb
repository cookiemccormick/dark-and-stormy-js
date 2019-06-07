Rails.application.routes.draw do
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'

  get '/home', to: 'welcome#home'

  resources :recipes
  resources :users

  resources :users, only: [:show] do
    resources :recipes, only: [:index]
  end

  resources :recipes, only: [:show] do
    resources :comments, only: [:create, :index]
  end

  get '/auth/facebook/callback', to: 'sessions#create'

  get 'recipes/:id/next', to: 'recipes#next'
  get 'recipes/:id/previous', to: 'recipes#previous'

  root 'static#home'
end