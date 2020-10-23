Rails.application.routes.draw do
  get '/users/:id', to: 'users#index'
  resources :dashboard

  match '/users/:id',     to: 'users#show',       via: 'get'
  devise_for :users, :path_prefix => 'd'
  resources :users, :only =>[:show]
  
  root 'welcome#index'
  resources :books
  resources :books do
  resources :comments
  end
end
