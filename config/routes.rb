Rails.application.routes.draw do
  root 'pages#index', as: 'index'

  get '/scenario', to: 'scenarios#new', as: 'new_scenario'
  post '/scenario', to: 'scenarios#create', as: 'create_scenario'
  get '/scenario/:id', to: 'scenarios#show', as: 'scenario'
  post '/scenario/:id', to: 'scenarios#auth', as: 'auth_scenario'
end
