Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  # get '/search', to: 'recipes#search'
  resources :recipes do
    member do
      post 'favorite'
    end

    collection do
      get 'search'
    end
  end

  resources :favorites, only: [:index, :show, :create]
  resources :cuisines, only: [:show, :new, :create, :index]
  resources :recipe_types, only: [:show, :new, :create]
end