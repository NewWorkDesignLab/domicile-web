Rails.application.routes.draw do
  root 'pages#index', as: 'index'
  get 'index.html', to: 'pages#index'

  ## USER ROUTES
  scope(path_names: {new: I18n.t('routes.misc.new'), edit: I18n.t('routes.misc.edit'), destroy: I18n.t('routes.misc.destroy')}) do
    get I18n.t('routes.misc.dashboard'), to: 'users#show', as: 'user'

    devise_for :users,
        path: I18n.t('routes.misc.users'),
        controllers: {
          confirmations: 'users/confirmations',
          passwords: 'users/passwords',
          registrations: 'users/registrations',
          sessions: 'users/sessions',
          unlocks: 'users/unlocks'
        },
        path_names: {
          sign_in: I18n.t('routes.misc.sign_in'),
          sign_out: I18n.t('routes.misc.sign_out'),
          sign_up: I18n.t('routes.misc.sign_up'),
          password: I18n.t('routes.misc.password'),
          unlock: I18n.t('routes.misc.unlock'),
          confirmation: I18n.t('routes.misc.confirmation'),
          cancel: I18n.t('routes.misc.cancel')
        }
  end

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
