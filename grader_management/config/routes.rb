Rails.application.routes.draw do
  get 'admin/index'
  get 'admin/approve_requests'
  get 'home/index'
  get 'sections/index'
  get 'sections/show'
  get 'courses/index'
  get 'courses/show'

  # user permitting
  get 'approve_requests', to: 'admin#index'
  put 'approve_requests', to: 'admin#approve_requests'

  # devise setting
  devise_for :users, controllers:{
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }

  #user sign-out
  devise_scope :user do
    get 'users/sign_out', to: 'devise/sessions#destroy'
  end

  resources :courses do
    resources :sections, only: [:index, :show]
  end

  root to: "home#index"

end
