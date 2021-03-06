Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get'/logout', to: 'sessions#destroy'
  delete '/logout', to: 'sessions#destroy'
  resources :microposts 
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  # resources :account_activations, only: [:edit]
end
