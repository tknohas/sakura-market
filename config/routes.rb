Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'admins/sessions' }
  namespace :admins do
    root 'home#index'

    resources :products, only: %i[new create edit update destroy]
  end
end
