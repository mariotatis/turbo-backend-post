# config/routes.rb
Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'posts#index'

  get '/profile', to: 'users#profile'
  get '/profile/settings', to: 'users#settings', as: :user_settings

  get '/home', to: 'pages#home', as: :home

  get 'liked', to: 'posts#index', liked: true
  get 'bookmarked', to: 'posts#index', bookmarked: true

  get 'turbo', to: "turbo#index", as: :turbo


  resources :posts do
    member do
      post 'toggle_like'
      post 'toggle_bookmark'
    end
  end
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'registrations/sessions' # Specify the custom sessions controller here
  }
  
end