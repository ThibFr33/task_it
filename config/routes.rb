Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :dashboards, only: [:index]
  resources :lists do
    resources :tasks, only: [:create, :update, :destroy]
    post 'ocr', on: :member
  end
  resources :reminders, only: [:new, :index, :update, :destroy] do
    post 'ocr', on: :member
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check



  # Defines the root path route ("/")
  # root "posts#index"
end
