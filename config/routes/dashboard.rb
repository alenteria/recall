namespace :dashboard do
  root to: 'base#index', as: ''
  resources :tickets do
  end
  post 'update-availability' => 'base#update_availability'
end