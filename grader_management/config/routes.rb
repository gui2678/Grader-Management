Rails.application.routes.draw do
<<<<<<< HEAD
  # Devise settings
=======
  # devise setting
>>>>>>> e67b9746ebbd4c02dc2911aee4a1605213aedc37
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }

  # User sign-out
  devise_scope :user do
    get 'users/sign_out', to: 'devise/sessions#destroy'
  end

  # Admin routes
  authenticated :user, ->(u) { u.admin? && u.approved? } do
    namespace :admin do
      get 'index'
      get 'approve_requests'
      get 'database-test', to: 'admin#test'
      post 'fetch_class_info', to: 'admin#fetch_class_info'
    end
  end

  # Home routes
  get 'home/index'

  # Course routes
  resources :courses do
    collection do
      get 'reload_courses'
      post 'do_reload_courses'
    end
    resources :sections, only: [:index, :show]
  end

  # Root path
  root to: "home#index"

  # Catch-all route for errors
  match '*unmatched', to: 'errors#not_found', via: :all
end
