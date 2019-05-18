Rails.application.routes.draw do

  resources :users, only: [:index, :new, :create, :destroy]
  resources :posts, only: [:index, :new, :create]

  root "posts#index"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

end
