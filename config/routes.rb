Rails.application.routes.draw do
  root   'static_pages#home'
  
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, :customers, :projects, :tasks
  resources :task_entries do 
    put '/start', to: 'task_entries#start_now'
    put '/stop', to: 'task_entries#stop_now'
  end
end
