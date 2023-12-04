# config/routes.rb
Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'posts#index'

  get '/profile', to: 'users#profile'
  get '/profile/settings', to: 'users#settings', as: :user_settings
  get '/profile/settings/password', to: 'users#password_update', as: :user_password_update

  get '/profile/settings/remove_account', to: 'users#remove_account', as: :remove_account



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

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  get '/posts/fetch_page/:post_id', to: 'posts#fetch_page', as: 'fetch_page'
  

  devise_for :users, controllers: {
    registrations: 'registrations/registrations',
    sessions: 'registrations/sessions' # Specify the custom sessions controller here
  }

  namespace :api do
    namespace :v1 do
      resources :posts, only: [:index]
    end
  end
  
end