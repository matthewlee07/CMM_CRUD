Rails.application.routes.draw do
  root   'static_pages#home'
  
  get '/users/new', to: 'users#new'
  get '/customers/new', to: 'customers#new'
  get '/projects/new', to: 'projects#new'
  get '/tasks/new', to: 'tasks#new'
  get '/task_entries/new', to: 'task_entries#new'

  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, :customers, :projects, :tasks
  resources :task_entries do 
    put '/start', to: 'task_entries#start_now'
    put '/stop', to: 'task_entries#stop_now'
  end
end
