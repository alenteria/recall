Rails.application.routes.draw do
  root to: 'home#index'
  draw :devise
  draw :dashboard
  draw :api
end
