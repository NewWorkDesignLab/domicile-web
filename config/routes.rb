Rails.application.routes.draw do
  root 'pages#index', as: 'index'

  resources :scenarios, only: [:new, :create]
end
