Rails.application.routes.draw do

  devise_for :users, controllers: { 
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'  
  }
  root 'home#index'
  resources :messages
  resources :conversations
  resources :histories
  resources :caterer_menus


  resources :reviews
  resources :caterer_informations
end
