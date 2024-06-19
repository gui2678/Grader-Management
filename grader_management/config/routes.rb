Rails.application.routes.draw do
  get 'home/index'
  get 'sections/index'
  get 'sections/show'
  get 'courses/index'
  get 'courses/show'
  get '/admin/database-test', to: 'admin#test'
  post '/admin/fetch_class_info', to: 'admin#fetch_class_info', as: 'admin_fetch_class_info'
  

  devise_for :users

  resources :courses do
    resources :sections, only: [:index, :show]
  end

  root to: "home#index"
end
