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

  #event types
  get '/event_types', to: 'event_types#index'
  get '/event_types/party', to: 'event_types#show'
  get '/event_types/wedding', to: 'event_types#show'
  get '/event_types/conference', to: 'event_types#show'
  get '/event_types/formal', to: 'event_types#show'
  get '/event_types/cocktail', to: 'event_types#show'
  get '/event_types/festival', to: 'event_types#show'


  


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
