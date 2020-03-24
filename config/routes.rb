Rails.application.routes.draw do
  root 'pages#index', as: 'index'
  get 'index.html', to: 'pages#index'

  ## PAGES
  get '/dashboard', to: 'pages#dashboard', as: 'dashboard'
  get '/impressum', to: 'pages#legal', as: 'legal'
  get '/datenschutz', to: 'pages#privacy', as: 'privacy'

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
end
