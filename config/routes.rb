Rails.application.routes.draw do
  get 'sessions/new'
  namespace :admin do
    resources :users
  end
  root to: 'tasks#index'
  resources :tasks
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
