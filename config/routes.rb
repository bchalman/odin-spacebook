Rails.application.routes.draw do
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}
  root 'static_pages#home'

  resources :users,           only: [:index, :show] do
    member do
      get :friends
    end
  end
  resources :friend_requests, only: [:create, :destroy]
  resources :friendships,     only: [:create, :destroy]
  resources :comments,        only: [:create, :destroy]
  resources :likes,           only: [:create, :destroy]
  resources :posts,           only: [:create, :destroy, :show]
end
