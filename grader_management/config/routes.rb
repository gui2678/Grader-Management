Rails.application.routes.draw do
  # devise setting
  devise_for :users, controllers:{
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }

  # user sign-out
  devise_scope :user do
    get 'users/sign_out', to: 'devise/sessions#destroy'
  end

  # admin routes
  get 'admin/index'
  get 'admin/approve_requests'
  put 'approve_requests', to: 'admin#approve_requests'
  get 'admin/database-test', to: 'admin#test'
  post 'admin/fetch_class_info', to: 'admin#fetch_class_info', as: 'admin_fetch_class_info'

  # home routes
  get 'home/index'
  # course routes
  resources :courses do
    collection do
      get 'reload_courses'
      post 'do_reload_courses'
    end
    resources :sections, only: [:index, :show]
  end

  # root path
  root to: "home#index"

end
