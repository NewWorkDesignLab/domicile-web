Rails.application.routes.draw do
  root 'pages#index', as: 'index'

  get '/scenario', to: 'scenarios#new', as: 'new_scenario'
  post '/scenario', to: 'scenarios#create', as: 'create_scenario'
  get '/scenario/:id', to: 'scenarios#show', as: 'scenario'
  post '/scenario/:id', to: 'scenarios#auth', as: 'auth_scenario'
  get '/scenario/destroy/:id', to: 'scenarios#destroy', as: 'destroy_scenario'

  namespace :api do
    get '/scenario/create', to: 'scenarios#create', as: 'api_scenario_create'
    get '/scenario/destroy', to: 'scenarios#destroy', as: 'api_scenario_destroy'
    get '/scenario/info', to: 'scenarios#info', as: 'api_scenario_info'
    get '/scenario/authenticated', to: 'scenarios#authenticated', as: 'api_scenario_authenticated'
  end
end
