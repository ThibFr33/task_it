Rails.application.routes.draw do
  devise_for :users, :controllers => { sessions: 'users/sessions' }
  root to: "dashboards#index"
  resources :dashboards, only: [:index]
  resources :lists do
    resources :tasks, only: [:create, :new]
    post 'ocr', on: :member
  end
  resources :tasks, only: [:update, :destroy, :edit]
  resources :reminders, only: [:new, :edit, :index, :update, :destroy, :create] do
    post 'ocr', on: :collection
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
