Rails.application.routes.draw do
  root   'static_pages#home'
  
  get '/users/new', to: 'users#new'
  get '/customers/new', to: 'custoemrs#new'

  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :customers
end
