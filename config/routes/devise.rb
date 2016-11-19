devise_for :users, controllers: {
  sessions: 'auth/sessions',
  confirmations: 'auth/confirmations',
  registrations: 'auth/registrations',
  passwords: 'auth/passwords',
  token_validations: 'auth/token_validations',
  omniauth_callbacks: 'auth/omniauth_callbacks',
  unlocks: 'auth/unlocks',
}

get '/users/auth/:provider', to: "auth/omniauth_callbacks#%{:provider}", as: :omniauth_authorize