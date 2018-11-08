Rails.application.routes.draw do

  devise_for :users, controllers: { 
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'  
  }

  root 'home#index'
  get 'about', to: 'about#index'

  ###### Event types #######
  get '/event_types', to: 'event_types#index'
  get '/event_types/parties', to: 'event_types#party'
  get '/event_types/weddings', to: 'event_types#wedding'
  get '/event_types/conferences', to: 'event_types#conference'
  get '/event_types/formal', to: 'event_types#formal'
  get '/event_types/cocktails', to: 'event_types#cocktail'
  get '/event_types/concerts', to: 'event_types#concert'
  ###### END #######
  ##### REVIEWS #######
  get '/review/new', to: 'reviews#new', as: 'new_review'
  post '/reviews', to: 'reviews#create'
  get '/reviews/:id', to: 'reviews#show', as: 'review'
  ##### END #######
  ##### HISTORIES ######
  get '/book/confirm/:id', to: 'histories#confirm', as: 'confirm_booking'
  get '/caterer_informations/:id/book', to: 'histories#new', as: 'new_booking'
  post '/process_payment', to: 'charges#process_payment', as: 'payment'
  resources :histories, only: [:index, :show, :create]
  ###### END ######
  resources :caterer_informations, only: [:show, :new, :edit, :create, :update, :destroy]
  resources :caterer_menus, only: [:new, :edit, :create, :update, :destroy]
  resources :conversations do
    resources :messages
  end
end
