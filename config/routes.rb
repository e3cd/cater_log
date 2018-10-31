Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'home#index'
  resources :histories
  resources :caterer_menus


  resources :reviews
  resources :caterer_informations
  resources :conversations do
    resources :messages
  end



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
