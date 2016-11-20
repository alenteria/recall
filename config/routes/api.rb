namespace :api do
  resource :contact_us, only: [:create]
  resources :ticket_logs, only: [:index, :create]
  resources :tickets, only: [:index] do
    collection do
      get :check_for_new
    end
  end
  resources :users, only: [] do
    collection do
      post :update_call_status
      get :check_if_available
    end
  end
  root to: 'js#index'
end