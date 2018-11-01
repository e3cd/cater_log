Rails.application.routes.draw do

  devise_for :users, controllers: { 
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'  
  }
  root 'home#index'
  resources :histories
  resources :caterer_menus


  resources :reviews
  resources :caterer_informations
  resources :conversations do
    resources :messages
  end

  get 'about', to: 'about#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
