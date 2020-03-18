Rails.application.routes.draw do
  root 'pages#index', as: 'index'
  get 'index.html', to: 'pages#index'

  ## PAGES
  get '/dashboard', to: 'pages#dashboard', as: 'dashboard'
  get '/impressum', to: 'pages#legal', as: 'legal'
  get '/datenschutz', to: 'pages#privacy', as: 'privacy'

  ## ONLY FOR TESTING, NEED REWORK AND THEN DELETE THIS
  get '/api/user', to: 'api#user'
  post '/api/image', to: 'api#image'
  get '/api/execution', to: 'api#execution'

  scope(path_names: {
          new: I18n.t('misc.routes.new'),
          edit: I18n.t('misc.routes.edit'),
          destroy: I18n.t('misc.routes.destroy')}) do

    ## USER ROUTES
    devise_for :users,
        path: I18n.t('misc.routes.users'),
        controllers: {
          confirmations: 'users/confirmations',
          passwords: 'users/passwords',
          registrations: 'users/registrations',
          sessions: 'users/sessions',
        },
        path_names: {
          sign_in: I18n.t('misc.routes.sign_in'),
          sign_out: I18n.t('misc.routes.sign_out'),
          sign_up: I18n.t('misc.routes.sign_up'),
          password: I18n.t('misc.routes.password'),
          confirmation: I18n.t('misc.routes.confirmation'),
          cancel: I18n.t('misc.routes.cancel')
        }

    ## SCENARIO ROUTES
    resources :scenarios, path: I18n.t('misc.routes.scenarios') do
      ## PARTICIPATION ROUTES
      resources :participations, only: [:show], path: I18n.t('misc.routes.participations'), controller: 'scenarios/participations' do
        ## EXECUTIONS ROUTES
        resources :executions, only: [:show], path: I18n.t('misc.routes.executions'), controller: 'scenarios/executions'
      end
    end

    ## PARTICIPATION ROUTES
    resources :participations, only: [:index, :new, :create, :show, :destroy], path: I18n.t('misc.routes.participations') do
      ## EXECUTION ROUTES
      resources :executions, only: [:show, :destroy], path: I18n.t('misc.routes.executions')
    end
  end

  # get '/scenario', to: 'scenarios#new', as: 'new_scenario'
  # post '/scenario', to: 'scenarios#create', as: 'create_scenario'
  # get '/scenario/:id', to: 'scenarios#show', as: 'scenario'
  # post '/scenario/:id', to: 'scenarios#auth', as: 'auth_scenario'
  # get '/scenario/destroy/:id', to: 'scenarios#destroy', as: 'destroy_scenario'

  # namespace :api do
  #   get '/scenario/info', to: 'scenarios#info'
  #   get '/scenario/exists', to: 'scenarios#exists'
  #   get '/scenario/auth', to: 'scenarios#auth'
  #   get '/scenario/create', to: 'scenarios#create'
  #   get '/scenario/destroy', to: 'scenarios#destroy'
  # end
end
