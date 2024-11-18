Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'admins/sessions' }
  namespace :admins do
    root 'products#index'

    resources :products, only: %i[index show new create edit update destroy]
  end
end
