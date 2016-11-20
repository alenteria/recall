namespace :api do
  resource :contact_us, only: [:create]
  resources :ticket_logs, only: [:index, :create]
  resources :tickets, only: [:index]
  root to: 'js#index'
end