Rails.application.routes.draw do
  root "home#index"

  # Devise setting
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
      get 'approve_requests', to: 'admin#approve_requests'
      get 'database-test', to: 'admin#test'
      post 'fetch_class_info', to: 'admin#fetch_class_info'
    end
  end

  get 'admin/approve_requests'
  get 'approve_requests', to: 'admin#approve_requests'

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

  # Grader Applications routes
  resources :grader_applications do
    member do
      patch 'approve'
    end
  end

  # Course Section Management Routes
  resources :courses do
    resources :sections do
      collection do
        get 'manage'
      end
    end
  end

  # Recommendation routes
  resources :recommendations, only: [:new, :create, :index]

  # Catch-all route for errors
  match '*unmatched', to: 'errors#not_found', via: :all
end
