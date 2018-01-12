Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  # get '/search', to: 'recipes#search'


  resources :recipes do
    collection do
      get 'search'
    end
  end
  resources :cuisines, only: [:show, :new, :create, :index]
  resources :recipe_types, only: [:show, :new, :create]
end