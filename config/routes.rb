Rails.application.routes.draw do

  devise_for :users, controllers: { 
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'  
  }
  root 'home#index'
  resources :histories
  resources :caterer_menus

  resources :reviews
  # resources :caterer_informations
  get '/caterer/new', to: 'caterer_informations#new', as: 'new_caterer'
  post '/caterer/new', to: 'caterer_informations#create'
  resources :conversations do
    resources :messages
  end



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
