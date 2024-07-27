Rails.application.routes.draw do
  # devise setting
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

  # course routes
  resources :courses do
    collection do
      get 'reload_courses'
      post 'do_reload_courses'
    end
    resources :sections, only: [:index, :show]
  end

  #Grader Applications routes

  resources :grader_applications do
    member do
      patch 'approve'
    end
  end

  # root path
  root to: "home#index"

  # Catch-all route for errors
  match '*unmatched', to: 'errors#not_found', via: :all
end
