Rails.application.routes.draw do
  devise_for :users

  # set the root of the site to the index action of the users controller
  root "users#index"

  # redirect /users to the root of the site
  get "/users", to: redirect("/")

  # redirect /users/:id to the show action of the users controller
  resources :users, only: [:show] do
    resources :posts, only: %i[index show new create destroy] do
      resources :comments, only: %i[new create destroy]
      resources :likes, only: [:create]
    end
  end
end
