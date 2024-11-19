Rails.application.routes.draw do
  root 'products#index'

  devise_for :admins, controllers: { sessions: 'admins/sessions' }
  namespace :admins do
    root 'products#index'

    resources :products, only: %i[index show new create edit update destroy] do
      resource :publish, only: %i[update destroy], module: :products
    end
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }
  resources :products, only: %i[index show]
  resource :address, only: %i[new create edit update]
end
