pul  resources :courses do
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
