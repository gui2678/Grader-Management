Rails.application.routes.draw do
  root "home#index"

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }

  devise_scope :user do
    get 'users/sign_out', to: 'devise/sessions#destroy'
  end

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

  get 'home/index'

  get 'sections_for_course/:course_id', to: 'sections#sections_for_course', as: 'sections_for_course'

  resources :courses do
    collection do
      get 'reload_courses'
      post 'do_reload_courses'
    end

    resources :sections, only: [:index, :show, :edit, :update] do
      member do
        get 'view_graders'
      end
    end
  end

  resources :grader_applications do
    member do
      patch 'approve'
    end
  end

  resources :recommendations, only: [:new, :create, :index]

  match '*unmatched', to: 'errors#not_found', via: :all
end
