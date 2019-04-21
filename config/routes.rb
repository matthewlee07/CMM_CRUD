Rails.application.routes.draw do
  root   'static_pages#home'

  get '/users/signupform', to: 'users#new'
  resources :users
end
