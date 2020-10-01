Rails.application.routes.draw do
  root 'pages#index', as: 'index'
  get 'index.html', to: 'pages#index'

  ## PAGES
  get '/dashboard', to: 'pages#dashboard', as: 'dashboard'
  get '/impressum', to: 'pages#legal', as: 'legal'
  get '/datenschutz', to: 'pages#privacy', as: 'privacy'
  get '/zuschauen/:id', to: 'pages#spectate', as: 'spectate'

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


    resources :scenarios,
            path: I18n.t('misc.routes.scenarios')
    resources :participations,
            only: [:index, :new, :create, :show, :destroy],
            path: I18n.t('misc.routes.participations')
    resources :executions,
            only: [:show, :destroy],
            path: I18n.t('misc.routes.executions')

  end

  namespace :api do
    mount_devise_token_auth_for 'User',
            at: 'auth',
            defaults: {format: 'json'},
            controllers: {
              sessions: 'api/devise_token_auth/sessions',
              passwords: 'api/devise_token_auth/passwords',
              registrations: 'api/devise_token_auth/registrations',
              confirmations: 'api/devise_token_auth/confirmations'
            }
    resources :scenarios, only: [:index, :show], defaults: {format: 'json'}
    resources :participations, only: [:index, :create, :show], defaults: {format: 'json'}
    resources :executions, only: [:create], defaults: {format: 'json'}
    post '/executions/:id/images', to: 'executions#upload_images'
    post '/bugreport', to: 'base#bug_report'
  end
end
