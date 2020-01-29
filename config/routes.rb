Rails.application.routes.draw do
  root 'pages#index', as: 'index'

  get '/scenario', to: 'scenarios#new', as: 'new_scenario'
  post '/scenario', to: 'scenarios#create', as: 'create_scenario'
  get '/scenario/:id', to: 'scenarios#show', as: 'scenario'
  post '/scenario/:id', to: 'scenarios#auth', as: 'auth_scenario'
  get '/scenario/destroy/:id', to: 'scenarios#destroy', as: 'destroy_scenario'

  namespace :api do
    get '/scenario/info', to: 'scenarios#info'
    get '/scenario/exists', to: 'scenarios#exists'
    get '/scenario/auth', to: 'scenarios#auth'
    get '/scenario/create', to: 'scenarios#create'
    get '/scenario/destroy', to: 'scenarios#destroy'
  end
end
