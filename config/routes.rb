Rails.application.routes.draw do
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'

  get '/home', to: 'welcome#home'

  resources :recipes
  resources :ingredients
  resources :users

  resources :users, only: [:show] do
    resources :recipes, only: [:show, :index]
  end

  resources :recipes, only: [:show, :index] do
    resources :comments, only: [:index, :new, :create]
  end

  get '/auth/facebook/callback', to: 'sessions#create'

  root 'static#home'
end