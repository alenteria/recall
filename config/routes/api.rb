namespace :api do
  resource :contact_us, only: [:create]
  resources :ticket_logs, only: [:index, :create]
end