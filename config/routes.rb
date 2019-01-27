Rails.application.routes.draw do
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}
  root 'static_pages#home'

  resources :users, only: [:index, :show]
  resources :friend_requests, only: [:create, :destroy]
end
