Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :teapots

  resources :orders, only: [:show, :create]
  resources :orders, only: [:show, :create] do
    resources :payments, only: :new
  end

  resources :checkouts, only: :show
  resources :payments, only: :show

  resources :cart_items, only: [:index, :create, :destroy] do
    collection do
      get :total_price
    end
  end


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root to: "teapots#index"
end
