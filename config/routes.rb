Rails.application.routes.draw do
  root   'static_pages#home'

  get '/users/new', to: 'users#new'
  resources :users
end
