Rails.application.routes.draw do
  root 'home#index'
  devise_for :admins, controllers: { sessions: 'admins/sessions' }
  namespace :admins do
    root 'products#index'

    resources :products, only: %i[index show new create edit update destroy] do
      resource :publish, only: %i[update destroy], module: :products
    end
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
end
