Rails.application.routes.draw do
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'

  get '/home', to: 'welcome#new'

  resources :recipes
  resources :ingredients
  resources :users

  resources :users, only: [:show, :index] do
    resources :recipes, only: [:show, :index, :new, :edit]
  end

  root 'static#home'
end