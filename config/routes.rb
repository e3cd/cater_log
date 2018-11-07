Rails.application.routes.draw do

  devise_for :users, controllers: { 
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'  
  }
  root 'home#index'

  ###### HISTORY/BOOKING ######
  resources :histories
  #### Look into changing the names of the routes when using resources #####
  # get '/history', to: 'histories#index', as: 'histories'
  # get '/book', to: 'histories#new', as: 'new_booking'
  # post '/history', to: 'histories#create'
  get '/book/confirm', to: 'histories#confirm', as: 'confirm_booking'
  # post '/book', to: 'histories#has_paid', as: 'payment'
  post '/process_payment', to: 'charges#process_payment', as: 'payment'
  # get '/success', to: 'histories#success', as: 'success'
  get '/caterer_informations/:id/book', to: 'histories#new', as: 'new_booking'
  ###### END #######

  ##### REVIEWS #######
  get '/review/new', to: 'reviews#new', as: 'new_review'
  post '/reviews', to: 'reviews#create'
  get '/reviews/:id', to: 'reviews#show', as: 'review'
  ##### END ######

  resources :caterer_menus

  
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
end
