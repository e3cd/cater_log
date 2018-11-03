Rails.application.routes.draw do

  devise_for :users, controllers: { 
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'  
  }
  root 'home#index'

  ###### HISTORY/BOOKING ######
  # resources :histories
  get '/history', to: 'histories#index', as: 'histories'
  get '/book', to: 'bookings#new', as: 'new_booking'
  post '/book', to: 'bookings#create'
  get '/book/confirm', to: 'histories#book', as: 'confirm_booking'
  post '/history', to: 'histories#create'
  ###### END #######

  resources :caterer_menus

  resources :reviews
  resources :caterer_informations
  # get '/caterer/new', to: 'caterer_informations#new', as: 'new_caterer'
  # post '/caterer/new', to: 'caterer_informations#create'
  resources :conversations do
    resources :messages
  end


  get 'about', to: 'about#index'

  #event types
  get '/event_types', to: 'event_types#index'
  get '/event_types/parties', to: 'event_types#party'
  get '/event_types/weddings', to: 'event_types#wedding'
  get '/event_types/conferences', to: 'event_types#conference'
  get '/event_types/formal', to: 'event_types#formal'
  get '/event_types/cocktails', to: 'event_types#cocktail'
  get '/event_types/concerts', to: 'event_types#concert'
  


  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
