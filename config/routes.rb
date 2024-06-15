Rails.application.routes.draw do
  devise_for :users
  resources :evaluations
  resources :tasks
  resources :scenarios

  # Set evaluation sequence
  resources :scenarios do
    member do
      get 'start'
      get 'evaluations'
    end
    resources :tasks, only: %i[show] do
      member do
        get 'next'
      end
      resources :gpt_prompts, only: %i[create]
      resources :evaluations, only: %i[new create]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "scenarios#index"
end
