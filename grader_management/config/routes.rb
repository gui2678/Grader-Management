Rails.application.routes.draw do
  get 'home/index'
  get 'sections/index'
  get 'sections/show'
  get 'courses/index'
  get 'courses/show'
  devise_for :users

  resources :courses do
    resources :sections, only: [:index, :show]
  end

  root to: "home#index"

  # Define other routes as needed
end
